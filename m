Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7323C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:03:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7CB208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OEz9bTH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZKYDNFfrQkNK+PMrnl1nSm0ntmm0+4XUS/n+D3WJH9k=; b=OEz9bTH2WoNevt
	BN4BbY/MJmAxv3NzaqgOXkn1vt5Y+JWfRKNFzP7HqWQwMqjBdDHLaL0JJu3zcVB5ZqMd8lkXt58hp
	1ju5RJp0qqDq4auW7xLZGQVbkwmtYS+GvaQSJnCA3592CZkwrIQcFN5COhq/oIWiyGzUlOFgAG/pR
	wrwze/CeosXO0gTDocR2fh6pkUYl02dfOPhuKrlmlG+tZ2jOpz6uVlUqXf4JCJvCMLWYOsHs+RAgx
	QqBtVfb//dvn4IrIbYnhTMy/p0CPDwcXOPm4XqtyRV5dahc62Qn+3BympCuyYq6uYSpgIZ7RS1gc5
	JnemWh3lC047vDuytGRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgC7-0006mD-3M; Wed, 05 Dec 2018 23:03:03 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgC3-0006la-J2
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:03:01 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 903FB803A;
 Wed,  5 Dec 2018 23:02:48 +0000 (UTC)
Date: Wed, 5 Dec 2018 15:02:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Message-ID: <20181205230242.GH6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com>
 <20181204231833.GF6707@atomide.com>
 <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
 <20181205190019.GG6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205190019.GG6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_150259_662410_B8E468EC 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [181205 19:00]:
> I think we're missing the top level ranges for mcasp l3 port
> and the translation goes wrong there, I'll fix it hopefully
> today.

Below is a fix for am473x that works for me as tested with
am473x-sk-evm. Care to test please?

I'll send also a similar fix for am335x separately. And
then for dra7. Looks like for dra7 we're also missing the
mcasp optional clocks too.

Regards,

Tony

8< ------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 5 Dec 2018 14:08:21 -0800
Subject: [PATCH] ARM: dts: Add missing ranges for am437x mcasp l3 ports

We need to add mcasp l3 port ranges for mcasp to use a correct l3
data port address for dma.

Fixes: d95adfd45853 ("ARM: dts: am437x: Move l4 child devices to
probe them with ti-sysc")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -613,7 +613,9 @@
 	ranges = <0x00000000 0x48000000 0x100000>,	/* segment 0 */
 		 <0x00100000 0x48100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x48200000 0x100000>,	/* segment 2 */
-		 <0x00300000 0x48300000 0x100000>;	/* segment 3 */
+		 <0x00300000 0x48300000 0x100000>,	/* segment 3 */
+		 <0x46000000 0x46000000 0x400000>,	/* l3 data port */
+		 <0x46400000 0x46400000 0x400000>;	/* l3 data port */
 
 	segment@0 {					/* 0x48000000 */
 		compatible = "simple-bus";
@@ -664,7 +666,9 @@
 			 <0x00034000 0x00034000 0x001000>,	/* ap 80 */
 			 <0x00035000 0x00035000 0x001000>,	/* ap 81 */
 			 <0x00036000 0x00036000 0x001000>,	/* ap 84 */
-			 <0x00037000 0x00037000 0x001000>;	/* ap 85 */
+			 <0x00037000 0x00037000 0x001000>,	/* ap 85 */
+			 <0x46000000 0x46000000 0x400000>,	/* l3 data port */
+			 <0x46400000 0x46400000 0x400000>;	/* l3 data port */
 
 		target-module@8000 {			/* 0x48008000, ap 6 10.0 */
 			compatible = "ti,sysc";
@@ -826,7 +830,8 @@
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x38000 0x2000>;
+			ranges = <0x0 0x38000 0x2000>,
+				 <0x46000000 0x46000000 0x400000>;
 
 			mcasp0: mcasp@0 {
 				compatible = "ti,am33xx-mcasp-audio";
@@ -857,7 +862,8 @@
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x3c000 0x2000>;
+			ranges = <0x0 0x3c000 0x2000>,
+				 <0x46400000 0x46400000 0x400000>;
 
 			mcasp1: mcasp@0 {
 				compatible = "ti,am33xx-mcasp-audio";
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
