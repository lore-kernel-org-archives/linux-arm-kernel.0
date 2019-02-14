Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8106C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8725420835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1zMETL3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oys6S3BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8725420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OWjRygzZe8PNVn3FE7ddoYUuWRwmmGmkUo7TWrqTUdY=; b=H1z
	METL36WUsjcAEnIvNge0cesZpGnvR9WQn0rpJhdor4CKJIKexZHW1uND6/ClzdoeSc4LSRQtG6Smx
	op8dvrmmOE5r95oX3v8o5VGLDkkmTsXNVwzLp5lIgM2nTFhEKBRvb6g0xErRqNzsMb7o1qBWV/2sc
	kmDA//OZaVwgXCI2GRInx5OoXhxa2EbD2uStTCNgZ0WNZUIdRrZ4+Iw9p6o+iwU6Q/vyXYHlXX9Kc
	L74nRurpVjd6Rd8xcIwRA/ML8AiWhpVmLSqBg71V300uT+fKlj9tOHBFKxH/vvHK/ZsLtGN05AIxx
	rH93zpmx1NSovfIegh0h2D/zo3p4LLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGlW-0001HG-8p; Thu, 14 Feb 2019 13:09:22 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGlS-0001Gp-0V
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:09:20 +0000
Received: by mail-pg1-x541.google.com with SMTP id r11so3052183pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=eeGeoU0xurxGwS3T8J3Qs6AIQrB91qKDaXpQlmfMjNc=;
 b=Oys6S3BQ7QXvNJ1Y3uR75qzfcn+UiBkJt58HqepB2oL0EggBQ0DKYKHXU2N3ehIKkE
 pd/ojEZ2B6GNkywUQF9LUjcnS+6stMegnIl8Q8CxvEKd1jBSIeH+KugIg0yG3XbTQV1V
 o3yObmmNxWatXMlWMnUxSAlOLD0BGhP07v4cf9hQPv8zCTVipgeIHCrg4pfRz345aBW7
 X3WNjLBTdSb3yEBGVrDRefdeow8SekVHJxsVfGlFZF9Lj0B8G1qln3hIL2Bux2ZQ09M7
 x1L3a9sBcA00x1u1wn6NM3dseOewlIU3zrymdBzpev3xDSqElPan87AzAj/RkHS2aJun
 0tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eeGeoU0xurxGwS3T8J3Qs6AIQrB91qKDaXpQlmfMjNc=;
 b=IfVKPRGAxGHQ+FtyhFbiK88vE6KrxER20mGJDLG5LeJmLT539A0QDFRabe3uBhYIfI
 jEEBeLC9Eszr2e1rw5BfyvzEtmZPCxbTZEW7B0L6W43XZ7GpW1/FKinJfuWTxjqSVN4d
 JE7BhvUqcPCpeLJ5aSkiQZis36DQwKwdDjSp25y4kRkoC+3zFFyz1kxHvFmq9B7AmkDB
 W9ZcLIZ9hMEwNKOxR+lYorBByrpvwzTo0kkVboQ4EHMyHsyu1FCK5pkiPvI2r7xKkKE1
 OAhe1nGyY6yc9o9Dn8RfivCeu2gWRS4oQIzWm0Neu3czdHUNWgMy7829KBUX0OVOkDHn
 N6nA==
X-Gm-Message-State: AHQUAuZHK79GDOkyP52vZcKq3yKbDNPZm6cIldtyhTY6okeeZ+iugltB
 5+ai/7qiPAyioH5wYA93LJ4=
X-Google-Smtp-Source: AHgI3IbX2IU5qoqbx9ScoTSOLf10PJ64/byqvusQUiw1YNyOQ7Lp6DTRSuSRdHc8Vtt+KPjhC7oqVA==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr3919860pfn.91.1550149756814;
 Thu, 14 Feb 2019 05:09:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id n73sm3347705pfj.148.2019.02.14.05.09.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:09:15 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com,
	wens@csie.org,
	robh+dt@kernel.org
Subject: [PATCH 0/4] arm64: dts: allwinner: h6: Enable CPU DVFS(cpufreq)
Date: Thu, 14 Feb 2019 08:09:06 -0500
Message-Id: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_050918_075486_0F531FC7 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the cpufreq support of h6, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

---
The patchset is based on the sunxi source code and has not been tested on an
actual board.
---

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 69 +++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
