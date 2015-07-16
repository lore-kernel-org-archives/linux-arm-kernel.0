From: zhengxing@rock-chips.com (zhengxing)
Date: Thu, 16 Jul 2015 19:22:17 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <20150716110032.GU11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl> <20150716110032.GU11162@sirena.org.uk>
Message-ID: <55A793E9.3050707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?16? 19:00, Mark Brown wrote:
> On Thu, Jul 16, 2015 at 10:05:44AM +0200, Paul Bolle wrote:
>
>>> +static struct platform_driver snd_rk_mc_driver = {
>>> +	.probe = snd_rk_mc_probe,
>>> +	.remove = snd_rk_mc_remove,
>>> +	.driver = {
>>> +		.name = DRV_NAME,
>>> +MODULE_ALIAS("platform:" DRV_NAME);
>> This seems only useful if there's a corresponding struct
>> platform_device. Ie, a platform_device with a "rockchip-snd-max98090"
>> .name, which will trigger a "MODALIAS=platform:rockchip-snd-max98090"
>> uevent when it's created. But I couldn't find where such a
>> platform_device is created.
>> Did I miss something? Or is there another way this alias is useful here?
> You've got platform_device and platform_driver confused I think.
Mark, Thank you.
