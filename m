From: denis.ciocca@st.com (Denis CIOCCA)
Date: Mon, 16 Sep 2013 11:32:45 +0200
Subject: [PATCH 38/38] iio: magn-core: st: Provide support for the
 LSM303DLH
In-Reply-To: <20130916073151.GB3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
 <5234A28D.1030409@kernel.org> <20130916073151.GB3999@lee--X1>
Message-ID: <5236D03D.2030506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,
> index 12e7e79..b2e2917 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -151,7 +151,8 @@ static const struct st_sensors st_magn_sensors[] = {
>   		.wai = ST_MAGN_1_WAI_EXP,
>   		.sensors_supported = {
>   			[0] = LSM303DLHC_MAGN_DEV_NAME,
> -			[1] = LSM303DLM_MAGN_DEV_NAME,
> +			[1] = LSM303DLH_MAGN_DEV_NAME,
> +			[0] = LSM303DLM_MAGN_DEV_NAME,
Are you sure that it works?
Because LSM303DLH magnetometer use different kind of WAI registers. This 
driver read 0x0f and in this case the value is 0 and the driver do not 
probe...You have to read the identification registers (0x0a, 0x0b, 0x0c) 
in that case.

Denis
