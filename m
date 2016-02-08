From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 17:09:38 +0100
Subject: [PATCH v2 0/3] fix and new support for orion5x based linkstation
In-Reply-To: <87lh6v19p4.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Mon, 08 Feb 2016 16:52:07 +0100")
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
 <1454738393-14114-1-git-send-email-rogershimizu@gmail.com>
 <87lh6v19p4.fsf@free-electrons.com>
Message-ID: <87d1s718vx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., f?vr. 08 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Roger,
>  
>  On sam., f?vr. 06 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:
>
>> Dear Orion5x Maintainer,
>>
>> Here're fix and new support for orion5x based linkstation devices.
>>
>> Firstly, it add the missing mtd flash support, which I consider a fix
>> and can be backported to stable kernels, so I made the patch explicit.
>>
>> Second, like the changes I made for kirkwood based linkstation DT,
>> I split the orion5x-linkstation-lswtgl.dts file into common and device
>> specific part, in order to support more devices.
>>
>> Third, so there's a new device.
>>
>> Hope this can be kindly accepted. Thank you!
>>
>> Changes in v2:
>> - add "Fixes" tag for patch 1/3
>> - add "mvebu-" prefix to common .dtsi file to share between orion5x
>>   and kirkwood, which address comment from Andrew Lunn
>> - add "Reviewed-by" tag from Andrew Lunn for all 3 patches
>>
>> Cheers,
>> Roger
>>
>> Roger Shimizu (3):
>>   ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl
>>   ARM: dts: orion5x: split linkstation lswtgl into common and device
>>     parts
>>   ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl
>
>
> The 3 patches have been applied on mvebu/dt

Humm, finally I moved the first patch to mvebu/fixes

Gregory

>
> Thanks,
>
> Gregory
>
>
>>
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |  72 +++++++
>>  .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    | 105 ++++++++++
>>  arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |  87 +++++++++
>>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   | 214 +++++----------------
>>  arch/arm/boot/dts/orion5x-linkstation.dtsi         | 180 +++++++++++++++++
>>  6 files changed, 491 insertions(+), 168 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
>>  create mode 100644 arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
>>  create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
>>  create mode 100644 arch/arm/boot/dts/orion5x-linkstation.dtsi
>>
>> -- 
>> 2.1.4
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
