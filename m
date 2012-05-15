From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 May 2012 19:30:35 +0100
Subject: [PATCH 3/4] ASoC: add imx-mc13783 sound support
In-Reply-To: <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120515183035.GG19592@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 01:53:51PM +0200, Philippe R?tornaz wrote:

> +	ret = snd_soc_dai_set_fmt(codec_dai, FMT_SSI);
> +	if (ret)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_fmt(cpu_dai, FMT_SSI);
> +	if (ret)
> +		return ret;

Set this in the dai_link structure.  Please fix incrementally unless you
respin, same comments about apply if Samuel is OK as the CODEC driver.

> +	ret = snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, 0);
> +	if (ret)
> +		return ret;

We should probably have something for this in the dai_link too but we
don't.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120515/38198701/attachment.sig>
