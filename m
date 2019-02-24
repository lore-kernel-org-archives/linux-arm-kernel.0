Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:36:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62AF20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nptvSLFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62AF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tuP4SD4Rchxh4ArmCPTEasG1jV76oM83c/b6+3KDRqw=; b=nptvSLFLeZa+oD
	TCxNuz9wIXhboyl0WJWkcW2/+gPNFgzI0BVoMdCXxETbED24Nqr25SdDCb3rwzSql7oPhhvFYaMUR
	GF7ITehZy5EN7zm/zUwcRmd5MzWRKl+FYnQACgYb5QwJr3iYpJaQElHH6j2V4JNTi/ue/wsgf/bHJ
	K7l08KpC1uL1Oa3iOz+jSVXO2J4cU2dkDydgSfAD0Vau3uLsbf/5aDaaErRN7K4ohXtprNSwHNU7c
	nILu2RLAxgBGfm+4NprwsUFYW3oQoX8MLtEpknu+uuk8mdrFfdbHHfqLW0jNyr7MEkJGalAmWWwxu
	jC6/EqmxkIhiJhTsMLZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxusl-0000wx-6f; Sun, 24 Feb 2019 14:35:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxush-0000wZ-7Q; Sun, 24 Feb 2019 14:35:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA3ADA78;
 Sun, 24 Feb 2019 06:35:48 -0800 (PST)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45D2A3F690;
 Sun, 24 Feb 2019 06:35:47 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] arm64: rk3399: Add capacity-dmips-mhz attributes
Date: Sun, 24 Feb 2019 14:35:25 +0000
Message-Id: <20190224143525.15539-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_063551_272394_20B6DECF 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Lin Huang <hl@rock-chips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The RK3399 has the interesting property to be a so called "big-little"
system, where not all the CPUs are equal (the A53s are much weaker
than the A72s).

So far, we're not telling the OS that there is such a difference in
processing capacity, and Linux assumes that they are equal. Too bad.

Let's tell the OS about this by using the capacity-dmips-mhz
property. The values used here are those used on the Juno platform,
which is quite similar. This leads to the scheduler knowing that
it can pack more tasks on the A72s, and leads to a better interactive
experience.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6cc1c9fa4ea6..7eab31184aee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -75,6 +75,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		cpu_l1: cpu@1 {
@@ -86,6 +87,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		cpu_l2: cpu@2 {
@@ -97,6 +99,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		cpu_l3: cpu@3 {
@@ -108,6 +111,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		cpu_b0: cpu@100 {
@@ -118,7 +122,7 @@
 			clocks = <&cru ARMCLKB>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu_b1: cpu@101 {
@@ -130,6 +134,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		idle-states {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
