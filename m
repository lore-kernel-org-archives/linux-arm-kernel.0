From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 10 Jul 2017 21:51:58 +0100
Subject: [PATCH 2/4] iio: dac: stm32: fix error message
In-Reply-To: <1499693040-12994-3-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
 <1499693040-12994-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170710215158.5f1689ef@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jul 2017 15:23:58 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix error message, there's no 'st,dac-channel' property, but 'reg'
> (see https://lkml.org/lkml/2017/4/3/567).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied.

Thanks,

Joanthan
> ---
>  drivers/iio/dac/stm32-dac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 50f8ec0..c1864e8 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -268,7 +268,7 @@ static int stm32_dac_chan_of_init(struct iio_dev *indio_dev)
>  			break;
>  	}
>  	if (i >= ARRAY_SIZE(stm32_dac_channels)) {
> -		dev_err(&indio_dev->dev, "Invalid st,dac-channel\n");
> +		dev_err(&indio_dev->dev, "Invalid reg property\n");
>  		return -EINVAL;
>  	}
>  
