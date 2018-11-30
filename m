Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:59:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2A12082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bWUHSdB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2A12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lLgLy6Y/DoXbuMYYda6rnzpBbrXHMhkOg+OA5bGC4Fk=; b=bWUHSdB+ZlpwhO
	2TI09vz1LGAE2XCDf0id/kDyPNpQ/16BrEupdqi8iy7XLPX2BDKak+AG7ibdqLKiPEKzmshTp1tl2
	i4iY1WkezLMNEsdixG899eZWE+pbtdbMoIbyadBfXvxF3AON3R4rkPSDe2QZiNzljVoj18Ic5W/Iy
	sJ2+hkQeQ3bB5O7O5O2gyitRTH2LXlUKq3TF46VlKJDuzzhEaIYmqFIJy8Rkwvy0YQhE/FqhaL43o
	GzoxsoAuzuyxRIxpMoyOpl2kct1Mtlmw0UwFXaJVM82Yy4k/lqP6HMe5M/kxD+ix7DjwOhcMz6plJ
	5c1/ugGQmVnB8bfHOJgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdhx-0000jW-15; Fri, 30 Nov 2018 07:59:29 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdhd-0000S2-7L
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:59:10 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 4F2665FD85; Fri, 30 Nov 2018 15:58:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/6] ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible for
 CSI controller
Date: Fri, 30 Nov 2018 15:58:46 +0800
Message-Id: <20181130075849.16941-4-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181130075849.16941-1-wens@csie.org>
References: <20181130075849.16941-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_235909_426470_7C1E9A98 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CSI controller found on the H3 (and H5) is a reduced version of the
one found on the A31. It only has 1 channel, instead of 4 channels for
time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
"fallback" to a compatible that implements more features than it
supports.

Drop the A31 fallback compatible.

Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 0d9e9eac518c..c9c9ec71945f 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -752,8 +752,7 @@
 		};
 
 		csi: camera@1cb0000 {
-			compatible = "allwinner,sun8i-h3-csi",
-				     "allwinner,sun6i-a31-csi";
+			compatible = "allwinner,sun8i-h3-csi";
 			reg = <0x01cb0000 0x1000>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_CSI>,
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
