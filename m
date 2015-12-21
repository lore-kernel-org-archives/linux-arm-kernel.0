From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 21 Dec 2015 13:59:59 +0100
Subject: [linux-sunxi] Re: [PATCH 0/5] ARM: dts: sunxi: Add backlight node
 to q8 tablets
In-Reply-To: <fc4adcf5-4362-4d4c-b42e-729922c79f65@googlegroups.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <fc4adcf5-4362-4d4c-b42e-729922c79f65@googlegroups.com>
Message-ID: <5677F7CF.3050308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-12-15 11:56, Silvio Pellicano wrote:
>
>
>> Here is a slightly updated version of Chen-Yu's backlight
>> patches, also adding support for the backlight found on A13
>> based q8 tablets.
>>
>
> If i compile your dtsi with (obviously) pwm  support enable , backlight
> switch off after kernel start,
> if i disable pwm in menuconfig,it stay on, all seem correct (pwm on PB2 in
> original script.bin),
> but there is somewhere a bug in pwm or dtsi description of backlight.

No there is not, if you enable the pwm driver you must also enable
the backlight-pwm driver / add CONFIG_BACKLIGHT_PWM=y to your .config
(and make sure it stays that way after a "make oldconfig").

Regards,

Hans
