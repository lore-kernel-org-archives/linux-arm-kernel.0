Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEE5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:40:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C373217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7gdZZ6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C373217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EFIwX19fHBTRLtp7frEcfhp/3ECI+w8zsqsS8gXzYG8=; b=M7gdZZ6u7Ty18/
	BrU+0xVbqtMmg/kJp/WYYSyE0Eue7ZOOhqWnHeGhQp9v96PDXK263H2n4MUAtptWtbeF0crIX2eNt
	p3RLA8nUYi71gHcnKbMStiSS5l03T0ga4V7Qlgsx3MNd16wh5nw4Z3hW1lzNiwHyYsgLdIq3YNMzA
	KTjIzqdgadJGEjwIwRle/5vFwzJ5dVuwMKWe7JjCAnzp/nov8YGSxfEeWJxMW0IjNs6AasCnBLnB+
	+mnC0of3NFZl/jWpI/3f9FGRaFd1VQ8+F6fi/Jinv31IippMWcPgyZEag8dn3optfgrs9OCABTyxV
	w/+MioLU/gAQsWq5ys/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsQ3q-0001ly-Fq; Sat, 09 Feb 2019 10:40:38 +0000
Received: from h1.radempa.de ([176.9.142.194] helo=mail.cosmopool.net)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsQ3m-0001lD-PW
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 10:40:36 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id 86FCE9007B2;
 Sat,  9 Feb 2019 11:40:29 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCbEjPcByYKs; Sat,  9 Feb 2019 11:40:28 +0100 (CET)
Received: from hdev.ccbib.org (unknown [IPv6:2a01:4f8:160:20c1::10:110])
 by mail.cosmopool.net (Postfix) with SMTP id C641F900286;
 Sat,  9 Feb 2019 11:40:27 +0100 (CET)
Received: by hdev.ccbib.org (sSMTP sendmail emulation);
 Sat, 09 Feb 2019 10:40:27 +0000
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv4] arm64: dts: allwinner: a64: teres-i: enable backlight
Date: Sat,  9 Feb 2019 10:40:18 +0000
Message-Id: <20190209104018.6765-1-harald@ccbib.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_024034_974976_B4E00164 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Harald Geyer <harald@ccbib.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable pwm and add a pretty standard backlight node.

The regulator is always on, but we include it anyway, because it is
required by the binding document.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Changes since v3:
 * Adjust brightness-levels to follow closer to an exponential law
 * Change default value to have a similar brightness to what we had
   before.

Changes since v2:
 * Drop all the other stuff that got merged a year ago.
 * Rebased on current sunxi/for-next branch
 * Add power-supply property (just to conform to the binding)
 * Use slightly different brightness-levels

Actually I tried omitting brightness-levels completely, as it is now
optional. However automatic calculation gives unreasonable results
(depending on the exact value of pwm period). A report has been sent
to the author of the code.


 .../arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 7b7b14ba58e6..0ec46b969a75 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -21,6 +21,15 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 0>;
+		power-supply = <&reg_dcdc1>;
+		brightness-levels = <0 5 7 10 14 20 28 40 56 80 112>;
+		default-brightness-level = <5>;
+		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 
@@ -131,6 +140,10 @@
 	status = "okay";
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
