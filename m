Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C28C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4F020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ehTLEU5T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mz1Zi8bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4F020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=rQz/2LLFbHFCup23dRbmaV40uR/LdJs4E71HvIyBYfA=; b=ehT
	LEU5TF977OYKfqy7cLMI2J4oHck6YIfMsLIMkNHrxqSmtujjykUaXZE9lco6zpkcYhMShlwaxei2N
	QzrROjB8H0kZgGR5A+uX/R6zDFDFPhUTEJpl8i78APWMPkJK2OYUbas4nq4ikkqMt9FWMoezKaJjQ
	3ibhufD2Dijgux9xCfoODXcgG8HkgW5f81nd0a8xTcOxII42YAVP4JUUzMZOKi5NyG5XPuY+Tx5Qt
	LKjrdpEFzqDk4fq/2ukLAvIeJ90omEreO6sNQMjJrPBsiDR9lGtEuYPG8XOdYkrlQ23Ydq5VH77z/
	rwlD3aDFF1TbtDxVg4m85Knxwfm3pdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVSQ-00040D-87; Thu, 13 Dec 2018 18:11:34 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVSL-0003u4-Op
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=PJvBoSy7I/n1utfMYZM7cPizZKJpmJ1inkdeBjTtdd4=; b=mz1Zi8bfrNhA
 99gWT5+oG4Q/PJ6NIwaejlDlA27BJaUDI3cF5z7e0NDFJZlWp88U4b3cSwasmATII5htWRgHpDa9X
 detW1k8LnV/h7k2BzrhdHA1e6JW+ZN0mae4celd38hGM3D1V3xo9sUMjgP31vccgRVqkBq6sl4tfH
 dL/ec=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXVSA-0002QF-5W; Thu, 13 Dec 2018 18:11:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id D38D311254D1; Thu, 13 Dec 2018 18:11:17 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Applied "dt-bindings: ASoC: xlnx,
 i2s: Document i2s bindings" to the asoc tree
In-Reply-To: <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213181117.D38D311254D1@debutante.sirena.org.uk>
Date: Thu, 13 Dec 2018 18:11:17 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_101129_972692_5AAF4D73 
X-CRM114-Status: GOOD (  13.14  )
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

   dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

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

From 644c2dcf2f2ea113602aa24170d3203942d3d140 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:36 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

Added documentation for I2S IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
new file mode 100644
index 000000000000..5e7c7d5bb60a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx I2S PL block
+
+The IP supports I2S based playback/capture audio
+
+Required property:
+ - compatible: "xlnx,i2s-transmitter-1.0" for playback and
+	       "xlnx,i2s-receiver-1.0" for capture
+
+Required property common to both I2S playback and capture:
+ - reg: Base address and size of the IP core instance.
+ - xlnx,dwidth: sample data width. Can be any of 16, 24.
+ - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
+		      supported channels = 2 * xlnx,num-channels
+
+Example:
+
+	i2s_receiver@a0080000 {
+		compatible = "xlnx,i2s-receiver-1.0";
+		reg = <0x0 0xa0080000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
+	i2s_transmitter@a0090000 {
+		compatible = "xlnx,i2s-transmitter-1.0";
+		reg = <0x0 0xa0090000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
-- 
2.19.0.rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
