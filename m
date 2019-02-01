Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F584C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D68621872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CRf67kSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D68621872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=naHyk3dNc6z8u1px+065PwkENYwV3Hc7NaZHl72SlCM=; b=CRf67kSpWQqPG1
	FbNsngK4YTp/ntNtmR6msgfIRl390h14edmSdxM4CQECCIYTRQpgrOjHr3xYaK5a+13Tfw1WF7Udt
	t66NmASlE0Sl8i65T9/dYEWs0ITFnqhm+YT+RA0/ukO4e72e0N7uCKcU36aBPKhtSriZg2ZRa7WaG
	Ex2+jZgkw9ScEKuuLx7FgxIel2mQkMn0oDpcB+LiiUJ4sh7dJWYkB0NRq15Hm9td9WsbzGsHJ3AkH
	X9NdjRDCbZPsi3xkE3Sg4MkWjChEB6xvOsHXUWxOe1rFHA+701HMermI1Ep+J6sRa2Zw3Z8Pux4hr
	sUhiqnxivtrOnDX5pVNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpX91-0004WX-IM; Fri, 01 Feb 2019 11:38:03 +0000
Received: from mail.cosmopool.net ([2a01:4f8:160:20c1::10:107])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpX8x-0004W8-DH
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 11:38:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id 76B7F901674;
 Fri,  1 Feb 2019 12:37:52 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EES6LgBXtyvu; Fri,  1 Feb 2019 12:37:49 +0100 (CET)
Received: from hdev.ccbib.org (unknown [IPv6:2a01:4f8:160:20c1::10:110])
 by mail.cosmopool.net (Postfix) with SMTP id B7914901500;
 Fri,  1 Feb 2019 12:37:48 +0100 (CET)
Received: by hdev.ccbib.org (sSMTP sendmail emulation);
 Fri, 01 Feb 2019 11:37:48 +0000
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Date: Fri,  1 Feb 2019 11:37:43 +0000
Message-Id: <20190201113743.10058-1-harald@ccbib.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_033759_757989_455662FF 
X-CRM114-Status: GOOD (  16.63  )
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
Cc: devicetree@vger.kernel.org, info@olimex.com,
 Mark Brown <broonie@kernel.org>, Harald Geyer <harald@ccbib.org>,
 ibu@radempa.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The TERES-I has internal speakers (left, right), internal microphone
and a headset combo jack (headphones + mic).

The headphone lines are multiplexed with the debug console.
The headphone and mic detect lines of the A64 are connected properly,
but AFAIK currently unsupported by the driver.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Hi all,

a couple of issues make this patch RFC:

hpvcc-supply vs. cpvdd-supply:
On the A64 manual the pin is called CPVDD and the binding documents
requires a cpvdd-supply property. However in the actual driver and
devicetrees so far hpvcc-supply is used. This is a very new binding,
so we have the luxury to decide either way, I think. Any input from
the devicetree maintainers would be appreciated.

debug console multiplexing:
Olimex have a userspace script that controls gpio PL9 during boot,
to select between HP and serial console. I guess this is not acceptable
for mainline.

The best solution I can see is to switch the HP jack from serial console
to audio once the audio drivers load. With this people can still capture
the bootlogs but everybody gets audio once the system is up and
switching back to console output is as simple as unloading the audio
drivers.

However the current implementation with a pinctrl group doesn't work:
The audio card device correctly claims the pin (ie I can't export the
gpio in sysfs anymore), but the pinctrl driver doesn't set the pin
to output.

Testing:
I don't have a headset with combo connector, so I could only test the
headphones output, but not the headset mic. If somebody happens to
have a TERES-I and a suitable headset, testing this would be nice.

TIA,
Harald

 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f9eede0a8bd3..d57049fbdaca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -70,6 +70,26 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	speaker_amp: audio-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&r_pio 0 12 GPIO_ACTIVE_HIGH>; /* PL12 */
+		sound-name-prefix = "Speaker Amp";
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	hpvcc-supply = <&reg_eldo1>; /* TODO: Use only one of these */
+	cpvdd-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
 };
 
 &ehci1 {
@@ -131,6 +151,14 @@
 	status = "okay";
 };
 
+&r_pio {
+	r_debug_select_pin: debug-select {
+		pins = "PL9";
+		function = "gpio_out";
+		output-high;
+	};
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -258,6 +286,31 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_debug_select_pin>;
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,widgets = "Headphone", "Headphone Jack",
+				    "Microphone", "Headset Microphone",
+				    "Microphone", "Internal Microphone",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Headphone Jack", "HP",
+			"Speaker Amp INL", "LINEOUT",
+			"Speaker Amp INR", "LINEOUT",
+			"Internal Speaker", "Speaker Amp OUTL",
+			"Internal Speaker", "Speaker Amp OUTR",
+			"Internal Microphone", "MBIAS",
+			"MIC1", "Internal Microphone",
+			"Headset Microphone", "HBIAS",
+			"MIC2", "Headset Microphone";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
