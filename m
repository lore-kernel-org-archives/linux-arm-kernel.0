From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 15 Nov 2015 10:42:39 +0000
Subject: [PATCH] iio: adc: xilinx: Fix VREFN scale
In-Reply-To: <1447273478-2530-1-git-send-email-thomas.betker@freenet.de>
References: <1447273478-2530-1-git-send-email-thomas.betker@freenet.de>
Message-ID: <5648619F.4040208@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/15 20:24, Thomas Betker wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> The scaling factor for VREFN is 3.0/4096 (not 1.0/4096), just as for
> VREFP. This is not immediately obvious from the specification (Xilinx
> UG480), but has been confirmed by Xilinx support.
> 
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0370624..02e636a 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -841,6 +841,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  			case XADC_REG_VCCINT:
>  			case XADC_REG_VCCAUX:
>  			case XADC_REG_VREFP:
> +			case XADC_REG_VREFN:
>  			case XADC_REG_VCCBRAM:
>  			case XADC_REG_VCCPINT:
>  			case XADC_REG_VCCPAUX:
> 
