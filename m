From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 18:15:49 +0200
Subject: [PATCH 06/14] ASoC: Add sun8i digital audio codec
In-Reply-To: <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004161549.GO5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +static const struct of_device_id sun8i_codec_of_match[] = {
> +	{ .compatible = "allwinner,sun8i-a33-codec" },
> +	{ .compatible = "allwinner,sun8i-a23-codec" },

I thought that the A23 and A33 had different codecs? In that case, it
wouldn't be a good assumption to make


> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> +
> +static struct platform_driver sun8i_codec_driver = {
> +	.driver = {
> +		.name = "sun8i-codec",
> +		.owner = THIS_MODULE,
> +		.of_match_table = sun8i_codec_of_match,
> +	},
> +	.probe = sun8i_codec_probe,
> +	.remove = sun8i_codec_remove,
> +};
> +module_platform_driver(sun8i_codec_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A33 (sun8i) codec driver");
> +MODULE_AUTHOR("huanxin<huanxin@reuuimllatech.com>");

Those obfuscated email adresses are not really helpful :)

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/b93afd78/attachment.sig>
