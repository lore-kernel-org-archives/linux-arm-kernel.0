From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 10 Sep 2018 10:25:08 +0200
Subject: [PATCH v2 4/4] media: cedrus: Select the sunxi SRAM driver in
 Kconfig
In-Reply-To: <20180909191015.20902-5-contact@paulk.fr>
References: <20180909191015.20902-1-contact@paulk.fr>
 <20180909191015.20902-5-contact@paulk.fr>
Message-ID: <16fd7291-f51b-b0bc-4299-97adbe197e54@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2018 09:10 PM, Paul Kocialkowski wrote:
> Since the sunxi SRAM driver is required to build the Cedrus driver,
> select it in Kconfig.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/staging/media/sunxi/cedrus/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/Kconfig b/drivers/staging/media/sunxi/cedrus/Kconfig
> index afd7d7ee0388..3b06283e4bf3 100644
> --- a/drivers/staging/media/sunxi/cedrus/Kconfig
> +++ b/drivers/staging/media/sunxi/cedrus/Kconfig
> @@ -3,6 +3,7 @@ config VIDEO_SUNXI_CEDRUS
>  	depends on VIDEO_DEV && VIDEO_V4L2 && MEDIA_CONTROLLER
>  	depends on HAS_DMA
>  	depends on OF
> +	select SUNXI_SRAM
>  	select VIDEOBUF2_DMA_CONTIG
>  	select MEDIA_REQUEST_API

I noticed this select, but CONFIG_MEDIA_REQUEST_API doesn't exist. It's
probably from an old version and I have dropped it from the patch that
added this.

No need for you to do anything.

>  	select V4L2_MEM2MEM_DEV
> 

Regards,

	Hans
