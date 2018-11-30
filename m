Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC54C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429382082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ocQesvKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429382082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yLCzsluCe425gpvZ88qTh+Q1ITTgJAQlpEc8JQXMTWg=; b=ocQesvKqd+6GYv
	u13j1AXJtUO28vwaxoUrUMbeH4EoJJVjMkFcfAqFfa20R1a6EZANQwYaQzpRKlzCImm8igtACeP9J
	YLxqBP+0dzgcy6tGWeY/apUMYc5k6qMqB8YatsZlvtv2/lvlxy0R+PJcWHcllX5lCvlo65GckQDci
	RNYTrXU7p20JcipC/4CHa5FU5vQfZDDIb7lnQC5+Mw6TUzFAdGTf/ontYyWz6CMCWTOOCOOydX+tr
	NfFg6NnYS1RIIw+fwpv+qIiCp6EQIHv4qKJd6GTTg7Cyma0XL/5Kwd1/D1ix3pHp91NMNO41F26Oo
	xkLSmav6rCi7XaV1S+1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXFr-00088Z-N8; Fri, 30 Nov 2018 01:06:03 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXFo-00088C-FI
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 01:06:01 +0000
Received: by mail-oi1-f195.google.com with SMTP id y23so3396015oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 17:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5bq1A+7sN43Im2BAwgIO1cEPT8jUvdcCM6xL/pu12Uc=;
 b=ThVJncQSgSGF7F+vrdD1IADun3Nwkw1L9l1jIOkdF31AcE5WDcRqve6fki+wT/9nMi
 rtT8gfoCT5Ed0inNDVDtxnWBVe7dFvd7hOf7GplnyYcs1rFAHdVkJCosJVD7yA07hWpZ
 qrYFZxfI3Mnb+S7x+YQQr8yPjzuPgezpBtDNbkAtedsZOobqfpVYszlqW2/8QulYkr3n
 tjG39pl0EB5zKPSeyyI3emCW/zBSvEu4JppChK+2HkhrM88a9CYJdz0jqYU7iKUKFSba
 Msio9QZA9GLb0y2hK/nmJb83+Pe2dRxDhG79SjWcwWJcq3oZqDhp3LGrTV5NiDu6GK/Y
 2cxg==
X-Gm-Message-State: AA+aEWYFxs15SwV3TKJ6Qwdch1OFfivzyTfZWSNUAO27ipBs38sdrqQP
 rKintLj+S2P2a2PFGsWf1qdmVss=
X-Google-Smtp-Source: AFSGD/XqZYnopAJgUJ8EyIvrUoI2edKnItBJTrtJ8TysQpamISJHX5MwgfTXDEgFUqqyt0hch8ZswA==
X-Received: by 2002:aca:b4c5:: with SMTP id d188mr2255428oif.309.1543539948677; 
 Thu, 29 Nov 2018 17:05:48 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id r9sm2556165otq.81.2018.11.29.17.05.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 17:05:48 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	arm@kernel.org
Subject: [PATCH] ARM: dts: realview-pbx: Fix duplicate regulator nodes
Date: Thu, 29 Nov 2018 19:05:47 -0600
Message-Id: <20181130010547.24757-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_170600_511933_8A633C50 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There's a bug in dtc in checking for duplicate node names when there's
another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
another section. Upon removal of skeleton.dtsi, the dtb fails to build
due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
by renaming the nodes to something unique. In the process, drop the
unit-address which shouldn't be present wtihout reg property.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/arm-realview-pbx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index a5676697ff3b..916a97734f84 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -44,7 +44,7 @@
 	};
 
 	/* The voltage to the MMC card is hardwired at 3.3V */
-	vmmc: fixedregulator@0 {
+	vmmc: regulator-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
@@ -52,7 +52,7 @@
 		regulator-boot-on;
         };
 
-	veth: fixedregulator@0 {
+	veth: regulator-veth {
 		compatible = "regulator-fixed";
 		regulator-name = "veth";
 		regulator-min-microvolt = <3300000>;
@@ -567,4 +567,3 @@
 		};
 	};
 };
-
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
