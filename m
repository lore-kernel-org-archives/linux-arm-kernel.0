From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:37:49 -0700
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
In-Reply-To: <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913163749.GK7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:

> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -423,6 +423,11 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
>  		return PTR_ERR(i2s->hclk);
>  	}
> +	ret = clk_prepare_enable(i2s->hclk);
> +	if (ret) {
> +		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
> +		return ret;
> +	}

BTW: you're also missing a clk_disable_unprepare() in the remove path
here, please send a followup fixing that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/2476a185/attachment.sig>
