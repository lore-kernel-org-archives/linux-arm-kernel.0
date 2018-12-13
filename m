Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE469C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC82A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8u2FgqM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qTZGigye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC82A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=82A1NmWTMoG7o3tCxy+bjCz9TwnJ7d9tDrro/5sRRw0=; b=L8u
	2FgqMagXFxEtk6rYsl3qSsK328eionKLoUPBj6WRkzARInzKkfCe3fn5q38tyZC/h+K81o5IVk244
	uD2snsOv6tXZ8QsENl2FR+41Uydbo1BnzbeDW54TN6oz0b3WYdnq3jtrC4dlqgQWDcvKEgOrAyKol
	VlTc/eunCdXMmZIveocjjweJ3/kODzfQHKJ0sLP75i/5yKJSgtke8QPLa2P8vNfwPtzDpXB+E1X6m
	HtWR4hoj4EzveIyrOmNzge1LpS+k3O2MQm/wPbUpKTlZ7/8QrYF0xZULEbh9lURnwl4l7zkzeq6dR
	5TaD3waLrrxB5mF2ZmzUb7PdhxWA2Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVT8-00052W-NK; Thu, 13 Dec 2018 18:12:18 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVSL-0003ty-Oq
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=PWbFfBVPCmVbTdEtl2l3KtoXEelef9XKWzA+JhRaxjM=; b=qTZGigye+vAT
 Cedk/knnbbn9DSYc1ZBS8AtQZwa6a1OXWfDntWb4JOtDp1r0e/zRDX2mnh9hTtNcrGffZ50dowCb5
 3bNZe+o6PeWaxPww+UxpYo6LEeJHd5v9l5mFO567meDyZLswUYSLUhdOzPkZgfFWIQS2h3BNGTBJS
 P4q40=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXVS8-0002Q5-Ac; Thu, 13 Dec 2018 18:11:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 017BE11254D1; Thu, 13 Dec 2018 18:11:15 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Applied "ASoC: xlnx: Add i2s driver" to the asoc tree
In-Reply-To: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213181116.017BE11254D1@debutante.sirena.org.uk>
Date: Thu, 13 Dec 2018 18:11:15 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_101129_977329_7A1C8475 
X-CRM114-Status: GOOD (  18.90  )
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

   ASoC: xlnx: Add i2s driver

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

From 112a8900d4b0399f45d6ea025d3e1a4a1d6fa3f3 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:37 +0530
Subject: [PATCH] ASoC: xlnx: Add i2s driver

I2S IP instance can work in transmitter/playback or receiver/capture mode
exclusively. The patch registers corresponding instance as ASoC component
with audio framework.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_i2s.c | 185 ++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
new file mode 100644
index 000000000000..d4ae9eff41ce
--- /dev/null
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ASoC I2S audio support
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ * Author: Praveen Vuppala <praveenv@xilinx.com>
+ * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "xlnx_i2s"
+
+#define I2S_CORE_CTRL_OFFSET		0x08
+#define I2S_I2STIM_OFFSET		0x20
+#define I2S_CH0_OFFSET			0x30
+#define I2S_I2STIM_VALID_MASK		GENMASK(7, 0)
+
+static int xlnx_i2s_set_sclkout_div(struct snd_soc_dai *cpu_dai,
+				    int div_id, int div)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (!div || (div & ~I2S_I2STIM_VALID_MASK))
+		return -EINVAL;
+
+	writel(div, base + I2S_I2STIM_OFFSET);
+
+	return 0;
+}
+
+static int xlnx_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *i2s_dai)
+{
+	u32 reg_off, chan_id;
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	chan_id = params_channels(params) / 2;
+
+	while (chan_id > 0) {
+		reg_off = I2S_CH0_OFFSET + ((chan_id - 1) * 4);
+		writel(chan_id, base + reg_off);
+		chan_id--;
+	}
+
+	return 0;
+}
+
+static int xlnx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *i2s_dai)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		writel(1, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		writel(0, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops xlnx_i2s_dai_ops = {
+	.trigger = xlnx_i2s_trigger,
+	.set_clkdiv = xlnx_i2s_set_sclkout_div,
+	.hw_params = xlnx_i2s_hw_params
+};
+
+static const struct snd_soc_component_driver xlnx_i2s_component = {
+	.name = DRV_NAME,
+};
+
+static const struct of_device_id xlnx_i2s_of_match[] = {
+	{ .compatible = "xlnx,i2s-transmitter-1.0", },
+	{ .compatible = "xlnx,i2s-receiver-1.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_i2s_of_match);
+
+static int xlnx_i2s_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+	u32 ch, format, data_width;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	dai_drv = devm_kzalloc(&pdev->dev, sizeof(*dai_drv), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = of_property_read_u32(node, "xlnx,num-channels", &ch);
+	if (ret < 0) {
+		dev_err(dev, "cannot get supported channels\n");
+		return ret;
+	}
+	ch = ch * 2;
+
+	ret = of_property_read_u32(node, "xlnx,dwidth", &data_width);
+	if (ret < 0) {
+		dev_err(dev, "cannot get data width\n");
+		return ret;
+	}
+	switch (data_width) {
+	case 16:
+		format = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	case 24:
+		format = SNDRV_PCM_FMTBIT_S24_LE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (of_device_is_compatible(node, "xlnx,i2s-transmitter-1.0")) {
+		dai_drv->name = "xlnx_i2s_playback";
+		dai_drv->playback.stream_name = "Playback";
+		dai_drv->playback.formats = format;
+		dai_drv->playback.channels_min = ch;
+		dai_drv->playback.channels_max = ch;
+		dai_drv->playback.rates	= SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else if (of_device_is_compatible(node, "xlnx,i2s-receiver-1.0")) {
+		dai_drv->name = "xlnx_i2s_capture";
+		dai_drv->capture.stream_name = "Capture";
+		dai_drv->capture.formats = format;
+		dai_drv->capture.channels_min = ch;
+		dai_drv->capture.channels_max = ch;
+		dai_drv->capture.rates = SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else {
+		return -ENODEV;
+	}
+
+	dev_set_drvdata(&pdev->dev, base);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &xlnx_i2s_component,
+					      dai_drv, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "i2s component registration failed\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "%s DAI registered\n", dai_drv->name);
+
+	return ret;
+}
+
+static struct platform_driver xlnx_i2s_aud_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = xlnx_i2s_of_match,
+	},
+	.probe = xlnx_i2s_probe,
+};
+
+module_platform_driver(xlnx_i2s_aud_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Praveen Vuppala  <praveenv@xilinx.com>");
+MODULE_AUTHOR("Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>");
-- 
2.19.0.rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
