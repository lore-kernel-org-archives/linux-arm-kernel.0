Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F906C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1887320872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r9rDpm3Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QznddbBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1887320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GQVecg5EFoikJUdIwlZdx97uyOsp+3eLK8AFbwY/xN4=; b=r9rDpm3Zwsp0DdW+/oixlLtx9a
	mV0aFCriNEkP/D5yOruYqyluJJa7y2/Q5UJwUo4/snPwVN2Hbh2L/J3N1l4q2mFubg+k7suy4yUWd
	lR9lbMS1bG1/2SBa7WQwWyRfLjA0CQUFZOh9rADAYFKs0iM+9bvBZSzq3ouJ6AQPstzWRY85/+kK9
	eZrPaGZHFDkPDTurbjwmI8vEgH2UapT+3T4//7GylpUaP1xdkOEXc43j/kjkYSnUg5CRt6jFsSuce
	jgemUXKLNBMEpF0yR1aRQystW8lkB+Op8EmAVxyjFGWaUGQDgCNkwrRvxt2LVLqDknvdtvjCEZI2B
	2ujXiBgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpGe-00042n-8Y; Fri, 11 Jan 2019 05:22:04 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpGD-0003fV-ON
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:21:51 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so6407519pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
 b=QznddbBrgj2tnWMvLRkfILQ3Z/rJLwyOYSkheShqUsZGPsNf5Hq7pmFfdzaysZD+4y
 RrWaMNMwVlIVgdkcLTQo7pUJZ7Rj6CUFe2Ecf4Y7mWE6xkGK1U5NANtoxjmwk8/AsOXa
 yJfWA2J4/YDw6EsBo4qeqWNNio6PKcE0StAj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OwRCj7PjZaXnprtMq6QV2wVOFtmvXlT2/KrfJ+jAcLc=;
 b=oxFcwztYYBKo4p/SMeANu2nrSEEktQ+ODd5ML1uxeBGaJyGWWxizPGfOtTcxvgeS/S
 +jxW4es7NXxo0tGK0HJb9ZRr6baPgXmIubCbDCaTR+8np6YPKezm+Gw6EAKh6amPTkcF
 /NvUx44KpiMXim5OfO6KuNna3NCKSPasJj9mgddKL1ti0rxXXllbJs9NQwWSjfT4bZIA
 PnHiPFFtpmHTki5i2rK7kABUo2u097tLLaw1VhWMJeUIovQg1GLWDUBByO/HTXaFB9Tj
 fkhx5oooKWhZVeuo6rPCEJ2eBUFflXtyjE62MkH6iec0Y8jxFFSQI367MGAMfN8F+/Dj
 Afww==
X-Gm-Message-State: AJcUukfbxuKwjmgpYpRfak7F75TWAaF3SdlIn13WHUu9+I2k5ggBEPaD
 sBQZI1yC05lXrqc8SCdwOHyCyA==
X-Google-Smtp-Source: ALg8bN77KebShN+aQwtyujxJ50Qw5574a7UnuGOyfElJju3nFY377rZoh0Obnu9ahLPuF0luY/Tstg==
X-Received: by 2002:a65:6542:: with SMTP id a2mr11969178pgw.389.1547184096264; 
 Thu, 10 Jan 2019 21:21:36 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:21:35 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 3/3] ARM: dts: cygnus: Change pwm compatible to new version
Date: Fri, 11 Jan 2019 10:51:16 +0530
Message-Id: <1547184076-20521-4-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_212138_286154_CF3346D7 
X-CRM114-Status: GOOD (  15.54  )
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
