Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ED3206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RaPESyD8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="enhOCcCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ED3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=keJCtuv3rz9e4CdyFb6cNKrg4eo9MYzQw95QLo9SuBk=; b=RaP
	ESyD8YFk03oexFNVOMSWAKY8pBMZPVktZ3j3NWf+b//mvcQjZhTFgKY8dnXmUFd/pVl1WhjnD+l6h
	uuwI4SsOeFTS0iZXBzi1SUEe0XuI1+Z6BtbNgk8dlZKYWcbe78E7xA2Of525Ek5jsc943NORI//Zd
	fxhsqqxRvYOIY1oYjC0w/PRXmbUDwvWXp6qFqHNbn1nmtfXtpIfQl/M4Zeefw6Hjs04QsQ6MyrRMc
	piw75RkxDbOPX8VXdDfa3yd2GmJy/zm8gDI3QemVdzishAtG/vhMl5eCezhH0fPHKmX1H0zxlz8cH
	OqSSEJRhlmerQuR/8p9KsmHDioPgffg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gga60-0001QX-3T; Mon, 07 Jan 2019 18:57:56 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gga5w-0001Pb-4K
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 18:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=ZeeKJbXY+PtlLSFSqvZ/6Qdr3OBdTj8OLT5IZjfgqHg=; b=enhOCcCAh1KN
 P4oBGUQAtiy0mqcUUCbciosYonfkwnuHeGZfbGbSFojgNwhUPR78tWiJ48+q+iMpaD2cnFd6a3wyu
 P3uBQcHZ/nA3XX+nhLJSFrzDvldCDbHT0Hq859BUOcQOoZHp4sfBS6qHOKT4/OiJ7unfavBBHFXTj
 JpkWk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gga5r-0007km-Q4; Mon, 07 Jan 2019 18:57:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 6B9541127491; Mon,  7 Jan 2019 18:57:47 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Applied "dt-bindings: ASoC: xlnx,
 spdif: Document spdif bindings" to the asoc tree
In-Reply-To: <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185747.6B9541127491@debutante.sirena.org.uk>
Date: Mon,  7 Jan 2019 18:57:47 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_105752_333302_16295DB3 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>,
 Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 2f00f7715e624d04e25d9cb8bb0f53884d3bcb59 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Thu, 3 Jan 2019 23:39:51 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

Added documentation for SPDIF IP DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
new file mode 100644
index 000000000000..15c2d64d247c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx SPDIF IP
+
+The IP supports playback and capture of SPDIF audio
+
+Required properties:
+ - compatible: "xlnx,spdif-2.0"
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_aclk", "aud_clk_i"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+ - reg: Base address and address length of the IP core instance.
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - xlnx,spdif-mode: 0 :- receiver mode
+		    1 :- transmitter mode
+ - xlnx,aud_clk_i: input audio clock value.
+
+Example:
+	spdif_0: spdif@80010000 {
+		clock-names = "aud_clk_i", "s_axi_aclk";
+		clocks = <&misc_clk_0>, <&clk 71>;
+		compatible = "xlnx,spdif-2.0";
+		interrupt-names = "spdif_interrupt";
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 4>;
+		reg = <0x0 0x80010000 0x0 0x10000>;
+		xlnx,spdif-mode = <1>;
+		xlnx,aud_clk_i = <49152913>;
+	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
