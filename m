From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 19:57:13 +0900
Subject: [PATCH 09/09] ARM: s3c2440: gta02: Add touchscreen support
In-Reply-To: <4D6B7CA5.9010708@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<1297043521-21903-9-git-send-email-lars@metafoo.de>
	<000201cbd70d$4f67f1f0$ee37d5d0$%kim@samsung.com>
	<4D6B7CA5.9010708@metafoo.de>
Message-ID: <003501cbd736$43c26410$cb472c30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
> 
> On 02/28/2011 07:04 AM, Kukjin Kim wrote:
> > Lars-Peter Clausen wrote:
> >>

(snip)

> >>  /* Buttons */
> >>  static struct gpio_keys_button gta02_buttons[] = {
> >>  	{
> >> @@ -533,6 +542,8 @@ static struct platform_device *gta02_devices[]
> > __initdata
> >> = {
> >>  	&samsung_asoc_dma,
> >>  	&s3c_device_i2c0,
> >>  	&gta02_buttons_device,
> >> +	&s3c_device_adc,
> >
> > No need to build plat-samsung/dev-adc.c for this?
> > If you want to add '&s3c_deivce_adc', should add 'select
SAMSUNG_DEV_ADC'
> > into "config MACH_NEO1973_GTA02".
> 
> There appear to be two different definitions for s3c_deivce_adc one is in
> plat-samsung/dev-adc.c the other is in plat-s3c24xx/devs.c. So if I select
> SAMSUNG_DEV_ADC I'll actually get compile errors.
> The definition in plat-s3c24xx/devs.c should probably be dropped, but
thats
> something for a different patch.
> 
Oops, you're right...ok, please keep your current code.
If required, we can do it later :)

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
