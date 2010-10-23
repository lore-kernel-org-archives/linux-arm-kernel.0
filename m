From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Sat, 23 Oct 2010 13:38:50 +0200
Subject: [PATCHv6 1/3] ARM: imx: Add gpio-keys to plat-mxc
In-Reply-To: <20101023095049.GC8554@pengutronix.de>
References: <1287801976-5324-1-git-send-email-Dinh.Nguyen@freescale.com>
	<4CC2977D.8060409@eukrea.com>
	<20101023095049.GC8554@pengutronix.de>
Message-ID: <4CC2C94A.9040700@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 23/10/2010 11:50, Uwe Kleine-K?nig a ?crit :
> On Sat, Oct 23, 2010 at 10:06:21AM +0200, Eric B?nard wrote:
>> Le 23/10/2010 04:46, Dinh.Nguyen at freescale.com a ?crit :
>>> +struct platform_device *__init imx_add_gpio_keys(
>>> +		const struct gpio_keys_platform_data *pdata)
>>> +{
>>> +	return imx_add_platform_device("gpio-keys", -1, NULL,
>>> +		 0, pdata, sizeof(*pdata));
>>> +}
>>
>> What is the added value of this ?
> Is is (more or less) in line with the other imx functions that
> dynamically add platform devices.
>
>> gpio-keys is not i.MX specific so why should that land in plat-mxc ?
> I consider it OK for now.  I know Eric does/wants something similar for
> pxa.  If you want to push forward unification here that's great, but
> IMHO this is nothing that should stop this patch which is a good step
> forward.
>
Does that mean that, for example, for cpuimx51 and cpuimx51sd boards, I should 
create : imx_add_gpio_leds, imx_add_serial_8250 and imx_add_i2c_gpio functions 
instead of creating the platform_device structure in the board's files and 
using platform_add_devices to register it ?

Thanks,
Eric
