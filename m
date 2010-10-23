From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 23 Oct 2010 11:50:49 +0200
Subject: [PATCHv6 1/3] ARM: imx: Add gpio-keys to plat-mxc
In-Reply-To: <4CC2977D.8060409@eukrea.com>
References: <1287801976-5324-1-git-send-email-Dinh.Nguyen@freescale.com>
	<4CC2977D.8060409@eukrea.com>
Message-ID: <20101023095049.GC8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Sat, Oct 23, 2010 at 10:06:21AM +0200, Eric B?nard wrote:
> Le 23/10/2010 04:46, Dinh.Nguyen at freescale.com a ?crit :
>> +struct platform_device *__init imx_add_gpio_keys(
>> +		const struct gpio_keys_platform_data *pdata)
>> +{
>> +	return imx_add_platform_device("gpio-keys", -1, NULL,
>> +		 0, pdata, sizeof(*pdata));
>> +}
>
> What is the added value of this ?
Is is (more or less) in line with the other imx functions that
dynamically add platform devices.

> gpio-keys is not i.MX specific so why should that land in plat-mxc ?
I consider it OK for now.  I know Eric does/wants something similar for
pxa.  If you want to push forward unification here that's great, but
IMHO this is nothing that should stop this patch which is a good step
forward.

BTW another low hanging fruit is to use use
platform_device_register_resndata to implement imx_add_platform_device
and add a few additional checks, like warn if CONFIG_DEBUG_SOMETHING is
enabled and data is non-NULL and doesn't point to .init-memory.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
