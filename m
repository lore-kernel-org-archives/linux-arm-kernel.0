From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Nov 2015 12:00:20 +0000
Subject: [PATCH v3 1/3] ASoC: rockchip: i2s: add 8 channels capture support
In-Reply-To: <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20151106120020.GH18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 09:38:09AM +0800, Sugar Zhang wrote:

> +	/* refine capture channels */
> +	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
> +		if (val >= 2 && val <= 8)
> +			rockchip_i2s_dai.capture.channels_max = val;
> +		else
> +			rockchip_i2s_dai.capture.channels_max = 2;
> +	}

You should make a copy of the rockchip_i2s_dai struct in your driver
data and modify that rather than modifying the original - what happens
if sommeone makes a SoC with two I2S DAIs, one with many channels and
another with only two?  Samsung SoCs often have an arrangement like that
for exmaple.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/abfa0950/attachment-0001.sig>
