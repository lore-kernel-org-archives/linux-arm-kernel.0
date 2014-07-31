From: spk.linux@gmail.com (Sachin Kamat)
Date: Thu, 31 Jul 2014 11:56:16 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <CAC5m3BwDvHVMJEfXE4w5zQ2RYXYt9PRF8uP=3M03Rr3Ls=N4eQ@mail.gmail.com>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <12165027.MHmNZOI7jc@wuerfel>
 <CAOesGMjo0AY=eGcfTh1sVxKkURK9bzK8SBAeEbvBFN4R0sF34A@mail.gmail.com>
 <CAC5m3BwDvHVMJEfXE4w5zQ2RYXYt9PRF8uP=3M03Rr3Ls=N4eQ@mail.gmail.com>
Message-ID: <CAK5sBcEPQtMvT+mp4+jXQA06FcBRTdAVJLbTCtCu-kV07Wh5RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 11:37 AM, Tushar Behera <trblinux@gmail.com> wrote:
> On Wed, Jul 23, 2014 at 1:58 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Tue, Jul 22, 2014 at 11:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Tuesday 22 July 2014 11:01:10 Olof Johansson wrote:
>>>> This is a major refresh of the multi_v7_defconfig:
>>>>
>>>> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
>>>>  * Enable big.LITTLE
>>>>  * MCPM
>>>>  * CYAPA touchpad
>>>>  * Samsung-related MTD/regulator/clk/pinmux drivers
>>>>  * Add some of the CrOS EC drivers
>>>> - Turn on TPM, HW_RANDOM
>>>> - OMAP_USB3 -> TI_PIPE3 option rename
>>>> - Enable MCPM/b.L for VEXPRESS
>>>> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
>>>> - CONFIG_LOGO, because penguins.
>>>>
>>>> I took care to keep the new options that have been added for whose the
>>>> drivers are not yet in our for-next branch. This was pretty awkward so
>>>> we should sort out how to handle those better in the future.
>>>
>>> Since you've already done all those, how about enabling THUMB2_KERNEL?
>>> For the multi_v7_defconfig, it should actually give some benefits,
>>> since it's rather large, and it would be good to have some more testing
>>> with this option enabled.
>>>
>>> I guess the first step would be to enable it and just see if your
>>> boot farm survives the change.
>>
>> Good point, I'll definitely give that a go once the current issues are resolved.
>>
>> Which are: These changes make 5250-based machines (snow and arndale)
>> break. Lots of i2c timeouts on SATA and hdmi-phy. Looks like arndale
>> might be missing pinctrl setups for it?

i2c timeout issue should have been fixed with the following patch:
i2c: i2c-s3c2410: Drop class based scanning to improve bootup time
(commit id: 6031d3dfc73b49bede540872e51a70ee0b6786d4) which is
available on Wolfram's I2C tree (should be part of linux-next too). Also
I do not see I2C_S3C2410 enabled in the config.
I do not have access to h/w today. I can verify and check tomorrow or
somebody could test it in the meantime with the above suggestions?

-- 
Regards,
Sachin.
