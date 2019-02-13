Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F23C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BED222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mWZpf51i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9m4qIn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BED222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sJRQOBVhLM6Gc7Y9yYaTe5buISIHTjlnad5xTPgSaSs=; b=mWZpf51iMZej0unCF8O5FX9LiU
	AQbz8Oky655+7ggLw6/AWJa4yC80E/JU3qjbDOb/jo6zpZNkkRRjlYoqgVmGU7PvJ+F+h+eiRL0er
	GG6mRNBz4UnCMN9T49lrycjvZ4YvB3xDMx+PwMn4CnJafMa33pm5Pomz2NgmCnMZ8IMV0cF9OT/Ok
	2MVpR/2VaMdit1hAhvbU5CtDc+aEDeH0V2nIRRIWmYD9l59eZSM9atCFzYdILWuzsc/+JNS0u66vk
	rSaTpjXC7U/B7o7MUYoT48b+7EQg8BW3mWmJIhSU8vdU+q6gfB+hrvuOfDMgPMSgmlFY7NZHO/urY
	qJDm1Stw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzDx-0005y6-UR; Wed, 13 Feb 2019 18:25:33 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzDn-0005le-7D
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:25:24 +0000
Received: by mail-qt1-x841.google.com with SMTP id e5so3703327qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n3Xu0BCtuANGPfTq7pDx0Dw85z3aUADWv9EPMLBjSo4=;
 b=V9m4qIn/fCaLOxUcOzm7UoN5r7xlxcDng8wp1/GvDikaPHYHBeBhok7kLX3yoedvkS
 +h9qI46A59EpnsDa1RbmzhqBIojDieOQVA4xEbF8MC5jrPVZJSThLPeiGWkyno64o+MU
 Ec95/lcr1ecTAt7pLnbjJH49zbXtlZmgdht7UxNRe1L1Xj+bxomU62t3l1ieA166q++M
 362T0pndE2ej+3tT+g4vqyHkTG3V2s6eH15A7Avfd8f795N4z330OEgd72HBQeIJj9Ku
 y4q+IXn9eetgH6qY4dh5cesYe0cwYFarffubN+niGxcjTK3VdnJ6UxAJdO4F+FEicYB2
 uM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n3Xu0BCtuANGPfTq7pDx0Dw85z3aUADWv9EPMLBjSo4=;
 b=M2+0+g2Rzy8864WGKbtkbR2lQugRXoaT8aEq3lKeWtJK3GIh4hTKiHiklvffxWtUgv
 CxU2hpl4jcvt6OaN1sfJkjgH/hgHx+n2KLUGQsvP1lqT2UhSVEyee2tH7YBS8dkKa7Ez
 R+zjvO+VlTey/tdoqxgGTl4QvXi/fqkShtYGDKICugwJeaz3RWYUaVQ4ikvtJV6aRM43
 rMxanMMpGAiSNSFzeVjPURrKMHIXqAg/AcDVgH+Sh0ZcK1V20YNIZ9OcvQckr3PPoPii
 RN+W0bR3OXBa4WdPXeC9dmCyIPDtE0PVuJLe/KrmrYi5dYKEWZOb9A5QkaJjV3bIM+1G
 EixQ==
X-Gm-Message-State: AHQUAuaEy/BawQ/PE4tGSc+wfx4gvyyy13alE2zHLiM1+8/ZivZO6VoH
 xxi+tB4m2E0sJBiAo1ifT5U=
X-Google-Smtp-Source: AHgI3IaEcr8gc5+WILMkWFfdRoF2f7bBeYI5l6z5X+fOyHZhwZdKIk8n9mZc48TRMz7GEiYHrk1P4g==
X-Received: by 2002:ac8:1a56:: with SMTP id q22mr1547602qtk.59.1550082321902; 
 Wed, 13 Feb 2019 10:25:21 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id l129sm1596796qkb.44.2019.02.13.10.25.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 10:25:21 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH v2 2/2] ARM: dts: vf610-zii-ssmb-spu3: Disable watchdog
Date: Wed, 13 Feb 2019 16:24:39 -0200
Message-Id: <20190213182439.6184-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213182439.6184-1-festevam@gmail.com>
References: <20190213182439.6184-1-festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_102523_259161_2B3FC13E 
X-CRM114-Status: GOOD (  11.18  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: andrew.smirnov@gmail.com, andrew@lunn.ch,
 Fabio Estevam <festevam@gmail.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On vf610-zii-ssmb-spu3 board there is a supervisory microcontroller that
provides the watchdog functionality, so disable the on-chip Vybrid's
watchdog. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 6df3ef979eb0..e10603bdd18f 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -254,6 +254,10 @@
 	};
 };
 
+&wdoga5 {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_dspi1: dspi1grp {
 		fsl,pins = <
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
