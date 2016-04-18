From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Apr 2016 18:22:03 +0100
Subject: [PATCH v4] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <1460983419-7705-1-git-send-email-pc.liao@mediatek.com>
References: <1460983419-7705-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <20160418172203.GL3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 08:43:39PM +0800, PC Liao wrote:

> +Optional properties:
> +- sound-dai: audio codec dai on capture path
> +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)

Code-wise this seems fine but it seems like it'd be clearer to call this
capture-dai - this isn't used to select whatr's used for playback, only
for capture.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/fdc7ad94/attachment.sig>
