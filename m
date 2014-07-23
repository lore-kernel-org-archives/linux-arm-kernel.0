From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Jul 2014 22:37:36 +0800
Subject: [PATCH 1/5] rtc: sun6i: Add sun6i RTC driver
In-Reply-To: <20140723095542.GN20328@lukather>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
 <1405323137-24287-2-git-send-email-wens@csie.org>
 <20140718080718.GI20328@lukather>
 <CAGb2v64K0iZ9e+1bdtkFVv5=t6nmTCTmUKeXLP-GvMaxAxQi+g@mail.gmail.com>
 <20140723095542.GN20328@lukather>
Message-ID: <CAGb2v643dOqRae38PBL+Jy0qVZ5Yv3SWA3QmEvRsyjTS=y1kSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 5:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, Jul 21, 2014 at 10:46:06PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Fri, Jul 18, 2014 at 4:07 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Mon, Jul 14, 2014 at 03:32:13PM +0800, Chen-Yu Tsai wrote:
>> >> This patch introduces the driver for the RTC in the Allwinner A31 and
>> >> A23 SoCs.
>> >>
>> >> Unlike the RTC found in A10/A20 SoCs, which was part of the timer, the
>> >> RTC in A31/A23 are a separate hardware block, which also contain a few
>> >> controls for the RTC block hardware (a regulator and RTC block GPIO pin
>> >> latches), while also having separate interrupts for the alarms.
>> >
>> > Do you plan on supporting those at some point?
>>
>> I haven't seen any devices use the regulator (which has an output pin).
>> I suppose we shouldn't add drivers for things we can't verify.
>> As for the GPIO pin latches, I'll have to experiment some more to figure
>> out what they do exactly.
>
> Ok.
>
>> > It's also worth noting that the first registers are supposed to
>> > control the source of the low frequency oscillator in the SoC, which
>> > will probably be the most troublesome, since we need these clocks very
>> > early on.
>>
>> That's true. I suppose the bootloader configures this. IIRC I've seen
>> code for this in boot0 or boot1 from Allwinner. I can't find the equivalent
>> for our sun4i u-boot though.
>
> Do you know what was the bootloader configuring it to?

I checked this some time ago, when I started to look at the sunxi clock code.
For all the devices (sun6/7/8i) I've checked, the system is configured to use
the external 32.768k oscillator.

> I don't really know how we can deal with this in a nice way, but I
> guess it's not so urgent.

I agree. I will look at the BROM (for sun4/7i) and boot0 (sun6i) for signs of
when it is configured. Then we can determine if we need to implement it
somewhere.

[...]

ChenYu
