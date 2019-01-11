Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA1D214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VoAN/twt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YbI3wrvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA1D214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GQVecg5EFoikJUdIwlZdx97uyOsp+3eLK8AFbwY/xN4=; b=VoAN/twtPkhHI5//8LqiC32wmn
	uMzLtXzQtJYXfsPs/i8Z7aQJgUDStaGBtO+zC0rgSBxKEbghl4C7SchvqEp9mAyTGNPAJeRCq6xrT
	vjaM/62xDuQiZuO2G8fr1ViW6esIajy7ggnj8nYg8gbM+TTBZu/uBUmMSrKgnJzQKpLPGAgMlyV+W
	AfXSI0fI7GfiODqR3wBlnu7PMW4KSc5GVd4r100L98Hxej4jZvfmmzYFoPECF5Q7BWRlo3lni6M+o
	kjzWRo/MQr0w5+i3t95u0BIm87MQ7AotzIE9UcWBub6evrOZnFBQ9deyCMw0by/abMKejuvZ457s7
	aMrd8Guw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghp3h-0006tf-UD; Fri, 11 Jan 2019 05:08:41 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghp2x-00067T-Gi
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:07:59 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so6391957pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
 b=YbI3wrvLQlSuWKzGwcmrPMq10BLR53H4wxvnakPX7SQwU5HynxVsjGZLrCXMFIFj2x
 58k7ckLKu03eDgblFwVjoFDjwOPilyx/eCtUbQtCihPvHo6vn6DKbmZ4t8Aouyns1RmJ
 t7aPVpar4xkh27FabgEw607ccngXv9ub2bFQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
 b=hkLXgRhekKyOvT/c29ePK38xfehIhEwSZbc106KNhocD3JHBqcytSjL310CTQSSdIz
 VqkZtZ/CJYb/DLssgnCuiBsR4bTkcsHl6iHNqZQfs+EiNT3UNyvooayO6vTJMGITUWOH
 EvTaPTy5hDTIQADGUilvDhdMpPfOPTwX9gD5gYpm2zvDFkABIspgn2L7sAmWPmxwkeIX
 e0nnYPUyNdvcqF+qj7DcZFuQw3CrfSjkcHuU9ogaG4FOZS8EE54AV91pOXtTbwTiE7MN
 DpY9vQI+YUw6mTfZwUShQ8rtL/1lvi7azZI1AWcUVhePxhp7skWwOnzAojiGqB52kXOg
 oX+Q==
X-Gm-Message-State: AJcUukdzlb91y/KyDUVC1jQ+nAeYsUUqEhq+fWGFYwQUT1Sg77RtNOaH
 T56J3kBVuB7KDnVfS7u7gqD76A==
X-Google-Smtp-Source: ALg8bN4TUjGB9NckJx6746/Yf8+tklNsDUzA144cpS08G0WVS6MwRqSqItBq9OTXaCLoCaOdAmfzhQ==
X-Received: by 2002:a63:6ac5:: with SMTP id
 f188mr12155983pgc.165.1547183274445; 
 Thu, 10 Jan 2019 21:07:54 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:07:53 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH INTERNAL V3 3/3] ARM: dts: cygnus: Change pwm compatible to
 new version
Date: Fri, 11 Jan 2019 10:38:04 +0530
Message-Id: <1547183284-19956-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_210756_493479_24F65078 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Praveen Kumar B <praveen.b@broadcom.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Change pwm compatible to new version of pwm-kona
Add new compatible to check pwm configure status

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df71..2a433e7 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		pwm: pwm@180aa500 {
-			compatible = "brcm,kona-pwm";
+			compatible = "brcm,kona-pwm-v2";
 			reg = <0x180aa500 0xc4>;
 			#pwm-cells = <3>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
