Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F888C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:15:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAF52084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BaroYofy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAF52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=IUNtghKDUihx/VvZubjhbK3eRZKDW/48kVMIv/lqhJw=; b=Bar
	oYofyE8C11KBpUUa5I7RC8kp++95FTTlzjXIhLYKCfKrRAZmJ98ir8eULNpCBkxMdGG4iXwQrmTzR
	8TsXTawHZyyM/bPcAcB1uTpQsd5g+STmnerOpbBWIYaXvovCBh/Zb6rlAvsg3BWKLnooolFJ6DUa7
	sA9nw5ANhM8+i3f5R8nPIjrJ7+8RYC1xVPhp14fKZE58TQ7NucH0evq8NRqy+H5TKoPkl2MPMPkVS
	ZCNxFAH4TOSz7p0SmbNLVZk3aIMjcv60mkhC62yJpKrZ8w2Foaa/U9PZx88vwzs2bTYQ6vWfqr2nv
	GKY3UquZ46A0kNAFp+psgfapjwyfjOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi7te-0007j4-Fy; Sat, 12 Jan 2019 01:15:34 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi7tb-0007ih-6d
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 01:15:32 +0000
Received: by mail-pf1-f194.google.com with SMTP id u6so7711530pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 17:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GD672gAf+NJ/i/p1Q31HSxEMluq474R7zK8XUn9lNTQ=;
 b=TzmpiPvK9u03yVRmvSV8yIYiDW5Ch9l4JHPJjRh+3EaZfDID6FsMGTnlRxNAueEcTC
 lLSHiHiZRqueNuja6wtp/o5TuFwvbPTsmBx4egWIlmnzuRpxY+oi6C+RPSS5ZU67sEYr
 hy+jAGJ1KvaN5WWkr5vWRyQljuna4NREeYcof+GZt3GXnTWFGdE3uM7HW/c3sLkb6zlT
 LquRDrtHGBWY/IbtTlG1h/a2O4cee/vKaWe7fPMYZi2k88FOhAlx1fYiCNY6HKHN7Iom
 QkFcaeJa8CCwwefd+DbSJ2yDyHQ3H7jVCamjqkvAGAoRHupSrRzJu6VY0szPVO3BER2y
 ovug==
X-Gm-Message-State: AJcUukecfCJHA+RBsSvUVFmKZO0sae+4G8wzitTHRS0pB8Xnpn9M1cW8
 yneHLNUYZLszP40Ke89l02m/RRXfjndP1Q==
X-Google-Smtp-Source: ALg8bN4NcgVc8Tppm/ezIImxw7LqHPtXaAlC8A0/KO20S18QEo05O0mPpBpJpjDkl+fmiPvFRBKfyg==
X-Received: by 2002:a63:d50f:: with SMTP id c15mr15395940pgg.287.1547255729032; 
 Fri, 11 Jan 2019 17:15:29 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id 24sm338228045pfl.32.2019.01.11.17.15.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 17:15:27 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: vf610-bk4: fix incorrect #address-cells for dspi3
Date: Sat, 12 Jan 2019 09:15:14 +0800
Message-Id: <20190112011514.8527-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_171531_241740_95900AE5 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Lukasz Majewski <lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The dspi3 is used as slave controller on vf610-bk4, and the default
'#address-cells = <1>;' setting in vfxxx.dtsi causes the following DTC
warning.

  DTC     arch/arm/boot/dts/vf610-bk4.dtb
../arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge): /soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI bus
  also defined at ../arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'

For spi device used as slave controller, '#address-cells' should be 0.
Let's overwrite the property in vf610-bk4.dts to fix the warning.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/vf610-bk4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index 689c8930dce3..b08d561d6748 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -110,11 +110,11 @@
 	bus-num = <3>;
 	status = "okay";
 	spi-slave;
+	#address-cells = <0>;
 
-	slave@0 {
+	slave {
 		compatible = "lwn,bk4";
 		spi-max-frequency = <30000000>;
-		reg = <0>;
 	};
 };
 
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
