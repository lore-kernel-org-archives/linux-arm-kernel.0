Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87724C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620C620880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iLnE80hx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HJJEbVdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620C620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=MWZ+5FSviBs0BJBFgWEAlAzUKmcwDucsa0it0qUfls8=; b=iLn
	E80hx25gvo/gXugxA38xIqK+soLL/sjdGhJAMRB0JQoWTcuD4/69D/DHeABnEU17yQW7mfAHdI8MM
	nPNnojilz5M0tzJ6OS+Kw/qq4uvw2z3QKiWXcyLiVhTx0YMc+2WKN06819OomoDZCNAjowfptU8N7
	X5SRvrKlW2hsxUDYufRxnZoQ8U25QrZCCqteskQhxCJCc7CG++k/IYoAMnfQderTyDO/cwhJ2Q3R0
	o9gcKzshQmguh9ZlCFdhXY9vIm/wEfZsSz/XMbBjk6H/ICrlx+43p/vUEmWahuJVlIgthfhTuu4pV
	BHVLXaJw5+om9xMJf36h1oWASv3quhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVSa-00048V-7m; Thu, 13 Dec 2018 18:11:44 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVSL-0003tx-Om
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=B0suIU4MhAEPp6xKThdC1RHg9Vyrc00yPpQc13GUcrY=; b=HJJEbVdT+ztd
 IOYHgmAeCjkefBZ6tSQUYFNZAILE/MFVdL+RfMtIXl0eHuwhddVlWsKET5a/bvkLiqaTEUbSN12KY
 xD9kTsxhbtWXL4ar66IZymrHrG2f8UGt4pBhSJQhgSNcIN3gn8MIniEMIIpmVdVKxcVL+XGZg6BCk
 A0BlQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXVS6-0002Px-CE; Thu, 13 Dec 2018 18:11:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 1210211254D1; Thu, 13 Dec 2018 18:11:14 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Applied "ASoC: xlnx: enable i2s driver build" to the asoc tree
In-Reply-To: <1544207558-72508-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213181114.1210211254D1@debutante.sirena.org.uk>
Date: Thu, 13 Dec 2018 18:11:14 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_101129_952267_820D59B1 
X-CRM114-Status: GOOD (  15.77  )
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

   ASoC: xlnx: enable i2s driver build

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

From 33f8db9a89200c18ff65d494a3dbd325d129e15e Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:38 +0530
Subject: [PATCH] ASoC: xlnx: enable i2s driver build

Enabled i2s driver build option.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig         | 1 +
 sound/soc/Makefile        | 1 +
 sound/soc/xilinx/Kconfig  | 8 ++++++++
 sound/soc/xilinx/Makefile | 2 ++
 4 files changed, 12 insertions(+)
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1cf11cf51e1d..d21659f5a7e2 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -73,6 +73,7 @@ source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/uniphier/Kconfig"
 source "sound/soc/ux500/Kconfig"
+source "sound/soc/xilinx/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87c3cfc..aff7b1989436 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= uniphier/
 obj-$(CONFIG_SND_SOC)	+= ux500/
+obj-$(CONFIG_SND_SOC)	+= xilinx/
 obj-$(CONFIG_SND_SOC)	+= xtensa/
 obj-$(CONFIG_SND_SOC)	+= zte/
diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
new file mode 100644
index 000000000000..25e287feb58c
--- /dev/null
+++ b/sound/soc/xilinx/Kconfig
@@ -0,0 +1,8 @@
+config SND_SOC_XILINX_I2S
+	tristate "Audio support for the the Xilinx I2S"
+	help
+	  Select this option to enable Xilinx I2S Audio. This enables
+	  I2S playback and capture using xilinx soft IP. In transmitter
+	  mode, IP receives audio in AES format, extracts PCM and sends
+	  PCM data. In receiver mode, IP receives PCM audio and
+	  encapsulates PCM in AES format and sends AES data.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
new file mode 100644
index 000000000000..6c1209b9ee75
--- /dev/null
+++ b/sound/soc/xilinx/Makefile
@@ -0,0 +1,2 @@
+snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
+obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
-- 
2.19.0.rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
