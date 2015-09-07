From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 7 Sep 2015 18:55:49 +0800
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable common Rockchip
 devices/busses
In-Reply-To: <1441621467.8778.26.camel@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <55ED585B.9030009@osg.samsung.com> <1441621467.8778.26.camel@collabora.co.uk>
Message-ID: <55ED6D35.6060704@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
     There are also many other devices like display and mmc and even
the cpu(if the cpu want run a high frequency when boot up)need to
get power supply from PMIC, so it is better to load PMIC as early as
possible.Built-in is a better choice.

On 2015?09?07? 18:24, Sjoerd Simons wrote:
> On Mon, 2015-09-07 at 11:26 +0200, Javier Martinez Canillas wrote:
>> Hello Sjoerd,
>>
>> On 09/06/2015 10:16 PM, Sjoerd Simons wrote:
>>> Enable Rockchip I2C, SPI, PWM, thermal drivers.
>>>
>>> Builtin are:
>>>   * I2C as it often controls the pmic.
>> Having I2C as a module will cause more probe deferrals due missing
>> regulators and slow down the boot but it should not cause issues.
>> Or am I missing something?
>>
>> In fact, I think even the PMIC could be built as a module.
> It could in principle. However as a lot of other drivers do need the
> regulators provided by the pmic, they'll be deferred until that driver
> is loaded. So e.g. with the i2c/pmic drivers as a module you cannot
> boot to an NFS rootfs without using an initramfs.
>
>> But I don't have a strong opinion on this so patch looks good:
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> Best regards,
