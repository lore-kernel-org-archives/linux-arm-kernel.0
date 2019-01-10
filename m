Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C04C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:29:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22D32177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rPKDBXhq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ZWdqLwDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22D32177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7Z5yPjmHmtf43AFUIeRWdPbsZSjvjfpmyGjXyzh2JvI=; b=rPK
	DBXhqW3Wgj6CVLByiRN0k6N/7ckvQ2OMYtbisCWqZ2cjgs2F6b8D727VeYjtJL4l88aKj5SS5QciI
	9ogKJlSEXNh2CaOoZ52ylFu+Vlt5TUCHNPxc3Xv4kyB6OjwVXd6F2X1iALI2L+9EjzMiasIddaWAt
	dopD597ez7zdQtrEU5w7O2/rt3zSZdh94oIXm6Sn175VUWna2Kseat3icf83IqGPA2urciIDk0cMq
	o6U5DdLv3ua+V9G4gx/uQFmOzeyvMzBn7lTslYuACh+wWb/o+83VFRR2+hNsniK+twQgMjM16Ci8l
	acAFSOquz5ih97SnF5D1Rhm7/QlzyPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbKM-0000IC-Uk; Thu, 10 Jan 2019 14:28:58 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbKJ-0000Hs-Hs
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:28:57 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2AD7425B78D;
 Fri, 11 Jan 2019 01:28:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547130532; bh=fZThQyC5Koq5AXMYyJb9TBHMB4uX/jHex3OlNiCVT/Q=;
 h=From:To:Cc:Subject:Date:From;
 b=ZWdqLwDD+5kXPE5WGQ1xGmt80pna3ia8qQw+Ha4FZeAvVjIFw0QTt7BzRcKoWwTO4
 7bFr2PCwuKkw2rKMHQIKfV92rzBug0/Vbx+5eSYk8rlkBxPTyUY3rnPh1m/Tw21jJ0
 VehqCeYIHE3Mc2HZ1RMuqm789XTa0CbHU3yu9jE8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 2F253940462; Thu, 10 Jan 2019 15:28:50 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of SDHI3
Date: Thu, 10 Jan 2019 15:28:33 +0100
Message-Id: <20190110142833.31577-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_062855_740633_A049742F 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add SDHI3 UHS pin control and use it when enabling HS200 support
for SDHI3.

Based on work by Takeshi Kihara.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Tested on top of renesas-devel-20190110-v5.0-rc1

[    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
[    3.055659] mmc0: new HS400 MMC card at address 0001
[    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
[    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
[    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
[    3.055659] mmc0: new HS400 MMC card at address 0001
[    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
[    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)

[    2.901527] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    2.909824] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
[    3.055659] mmc0: new HS400 MMC card at address 0001
[    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
[    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)

128+0 records in
128+0 records out
134217728 bytes (134 MB) copied, 0.92438 s, 145 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 9.02486 s, 59.5 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 7.36003 s, 72.9 MB/s

512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 11.0156 s, 48.7 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 7.15907 s, 75.0 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 8.78869 s, 61.1 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.3861 s, 51.7 MB/s

The above test results seem favourable when compared to
testing against renesas-devel-20190110-v5.0-rc1 where the eMMC
device uses HS200 mode.

512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.7343 s, 36.4 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 8.46809 s, 63.4 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.6945 s, 36.5 MB/s

512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 19.1677 s, 28.0 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 21.3139 s, 25.2 MB/s
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 19.9205 s, 27.0 MB/s
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 89383aa35d65..f2846c9eb83f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -535,6 +535,12 @@
 		power-source = <1800>;
 	};
 
+	sdhi3_pins_uhs: sd3_uhs {
+		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
+		function = "sdhi3";
+		power-source = <1800>;
+	};
+
 	sound_pins: sound {
 		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data";
 		function = "ssi";
@@ -689,12 +695,13 @@
 &sdhi3 {
 	/* used for on-board 8bit eMMC */
 	pinctrl-0 = <&sdhi3_pins>;
-	pinctrl-1 = <&sdhi3_pins>;
+	pinctrl-1 = <&sdhi3_pins_uhs>;
 	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_1p8v>;
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
