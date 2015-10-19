From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 20:13:12 +0100
Subject: [PATCH v1 3/4] ASoC: Add codec machine driver for RK3036
In-Reply-To: <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20151019191312.GQ32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 09:01:08AM +0800, Shunqian Zheng wrote:
> From: ZhengShunQian <zhengsq@rock-chips.com>
> 
> This patch add the machine driver for rk3036.

Like Sjoerd said this looks like it migh be better just using
simple-card, if not...

> +	ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set cpu DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);

Set this in the dai_link struct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/1c449c1f/attachment.sig>
