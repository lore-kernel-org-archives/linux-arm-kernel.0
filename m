From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jan 2014 11:11:41 -0800
Subject: PWM...
In-Reply-To: <59642204.3UzJCDJHaS@wuerfel>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <20140119190324.GC28056@quad.lixom.net>
 <59642204.3UzJCDJHaS@wuerfel>
Message-ID: <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 19 January 2014 11:03:24 Olof Johansson wrote:
>> >
>> > Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
>> > be specified in the pwms declaration in pwmleds.  So that doesn't work.
>> > There's no property to tell pwmleds that it should use inverted sense
>> > either.
>>
>> Adding a property for active-low to the pwm-leds binding would be
>> easy, and backwards compatible. I'm surprised the original binding
>> didn't specify it. The leds-pwm driver already seems to support it for
>> C-configured instances.
>>
>> I'm also surprised that the imx pwm driver even has a #pwm-cells of
>> two, since the driver only supports one output. It'd be nice if they
>> had allocated the extra cell for flags, but it's hard to change now,
>> unless you do a new binding/compatible value and deprecate the old one.
>
> Actually I think it's not that hard to change: The binding can specify
> that either #pwm-cells=<2> or #pwm-cells=<3> is supported, and the
> driver extended to handle both cases. This would maintain backwards
> compatibility for old dtb files, though no forward compatibility for
> new dtb files with old kernels.

Ah, yes, if you add a cell that can be done. There'll still be the
"dead" first cell that will always be 0, but that's alright.


-Olof
