From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 May 2018 08:13:05 +0900
Subject: [PATCH 1/3] spi: meson-axg: support MAX 80M clock
In-Reply-To: <20180503213645.20694-2-yixun.lan@amlogic.com>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-2-yixun.lan@amlogic.com>
Message-ID: <20180503231305.GC13402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 09:36:42PM +0000, Yixun Lan wrote:

>  static const struct of_device_id meson_spicc_of_match[] = {
> -	{ .compatible = "amlogic,meson-gx-spicc", },
> -	{ .compatible = "amlogic,meson-axg-spicc", },
> +	{
> +		.compatible	= "amlogic,meson-gx-spicc",
> +		.data		= &meson_spicc_gx_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-spicc",
> +		.data		= &meson_spicc_axg_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, meson_spicc_of_match);

This is changing the DT bindings but there's no update to the DT binding
documentation, please add an update there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/bfd45740/attachment.sig>
