Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCD220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cXSSefeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCD220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uiHQjISZK0X1hgg+cFJiWY4EkoVmSl4Gzq52XbO81p8=; b=cXSSefeK7I41IO
	ltAetgYbK12pU+qserzjRAlXJXH22XVgsJ95pqjw/zS9YCnjD9z01HKfRNx4JLvtSB1I03wfppKER
	wzJMdN1BD1MhzDJejYhWgRVvPE4m3QrQUOtkJzgSuVyNlQBn5THtIg9V0tpVoTxSZLISTO6V7NR6x
	p30aBOwgBw9Qf6VOHSjPDMQ090WTlfmiG46hnBlk8dkN8EhCOGXBhoxR5MnwV7Yv3Mu2MGo5OQc+Y
	6eJisEzB+cSoAMJTiJ3zbGlynoO6TrnAYESeawhk4oLoSdUKPOxH61jiHhvHpgdQ6hIbf84BrEq7G
	BPlElL4nz7V4mBGRR4Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpgV-00068P-2L; Mon, 03 Dec 2018 14:58:55 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpgI-0005vV-EM
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:58:44 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 4E66A5FD80; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/14] dt-bindings: rtc: sun6i-rtc: Add compatible strings
 for pre-H6 variants
Date: Mon,  3 Dec 2018 22:58:13 +0800
Message-Id: <20181203145825.20511-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065842_619580_B0628335 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While doing Bluetooth enablement for various boards based on various
Allwinner SoCs, minor differences in the RTC modules were found. These
include a lack of an external clock output (A31), different internal
oscillator frequencies (H3/H5/A64/V3/V3s), different regulator voltage
settings (H5/H6), and the presence of miscellaneous registers unrelated
to the RTC (A64/R40/H5/H6). The datasheet also describes different number
of registers for non-volatile storage, though based on actual experiments
the actual number is the same across the board.

This patch adds a list of all pre-H6 variants, grouped by the internal
oscillator's clock rate, regulator settings, and the presence of the
external clock output. Combinations are introduced for the variants that
have miscellaneous registers.

The RTC block in the H6 also handles the 24 MHz DCXO. This will require
more device tree binding changes and will be done later.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/rtc/sun6i-rtc.txt        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index fed0d58cbfec..037ec475f412 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -3,7 +3,21 @@
 RTC controller for the Allwinner A31
 
 Required properties:
-- compatible	: Should be "allwinner,sun6i-a31-rtc"
+- compatible	: Should be one of the following combinations:
+		    - "allwinner,sun6i-a31-rtc"
+		    - "allwinner,sun8i-a23-rtc"
+		    - "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-r40-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-v3-rtc"
+		    - "allwinner,sun50i-a64-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun50i-h5-rtc"
+
+		  Where there are two or more compatible strings, this
+		  denotes the hardware covered by the most specific one
+		  is backward-compatible with the latter ones, and the
+		  implementation for the latter ones can be used, albeit
+		  with reduced functionality.
+
 - reg		: physical base address of the controller and length of
 		  memory mapped region.
 - interrupts	: IRQ lines for the RTC alarm 0 and alarm 1, in that order.
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
