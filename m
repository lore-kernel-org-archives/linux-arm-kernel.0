From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Oct 2010 17:50:19 -0700
Subject: [PATCH 1/2] ASoC: Add CS4271 codec support
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Message-ID: <20101007005018.GD30751@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 01:39:01PM +1300, Ryan Mallon wrote:

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -138,6 +138,9 @@ config SND_SOC_CS4270_VD33_ERRATA
>  	bool
>  	depends on SND_SOC_CS4270
>  
> +config SND_SOC_CS4271
> +	tristate
> +
>  config SND_SOC_CX20442
>  	tristate
>  

Oh, one actual problem: you should add the driver to SND_SOC_ALL_CODECS
too so we get build coverage for testing.
