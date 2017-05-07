From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 7 May 2017 16:03:01 +0100
Subject: [PATCH v2 3/3] iio: tools: generic_buffer: increase trigger length
In-Reply-To: <1493900000-26220-4-git-send-email-eugen.hristev@microchip.com>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <c02626ec-4580-ef36-3b38-535e18531473@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 13:13, Eugen Hristev wrote:
> Increased trigger length to 64 in order to cope with trigger names
> like fc030000.adc-dev0-external-rising
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Might as well change this now.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  Changes in v2:
>  - Modified trigger name length to 64
> 
>  tools/iio/iio_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 780f201..8b379da 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,7 +13,7 @@
>  #include <stdint.h>
>  
>  /* Made up value to limit allocation sizes */
> -#define IIO_MAX_NAME_LENGTH 30
> +#define IIO_MAX_NAME_LENGTH 64
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
>  #define FORMAT_TYPE_FILE "%s_type"
> 
