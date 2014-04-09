From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Apr 2014 00:27:32 +0800
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <20140409151747.GH28585@lukather>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
 <20140409151747.GH28585@lukather>
Message-ID: <CAGb2v67+YNhw2MXSu9DTKSUfXH=v+uD7KEaxyiPezyf9CYtmPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 9, 2014 at 11:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Apr 09, 2014 at 10:53:13PM +0800, Chen-Yu Tsai wrote:
>> Hi Boris,
>>
>> On Wed, Apr 9, 2014 at 9:51 PM, Boris BREZILLON
>> <boris.brezillon@free-electrons.com> wrote:
>> > Hello,
>> >
>> > This series rework the sunxi pinctrl driver to support the PLx pins
>> > available on the A31 SoC.
>>
>> Thanks for working on this. I mentioned to Maxime on IRC yesterday that
>> we have complete pinctrl drivers for both A31 and A23, based on our current
>> pinctrl-sunxi driver, in the A23 SDK. These have the complete pin mapping.
>>
>> > It also add missing A31 reset controller DT bindings documentation.
>> >
>> > I need those PL pins (actually I only need PL0 and PL1) to support
>> > the P2WI bus, which in turn is used to communicate with the AXP221
>> > PMIC.
>>
>> If you could, please add all the PL and PM pins.
>> As I said, you can find complete definitions in the A23 SDK.
>
> We have no idea what these PM pins are for the A31. And this code only
> is of interest for the A31 for the moment. Let's not take into account
> the A23 for now as far as the pin definitions are concerned.

Yes I was referring to the A31. In the A23 SDK, sun8iw1 refers to A31.
As for the PM pins, the A31 EVB fex file uses one PM pin for LCD backlight
control. And don't take my word for it. A31 standard design schematics from
Omilex clearly show PL/PM pins with the possible functions on the top left of
page 7. See:

https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/A31-PDFs/A31_PAD_STD_V1_90_130225.pdf

>> > Let me know if these changes are too intrusive.
>>
>> I wonder if we should do a separate driver for the new PIO controller.
>> Clearly it's a separate IP block, with it's own clock and reset controls.
>
> It's been merged together in the A23, hence why we did it like that.

I'm not sure I understand. The clock gate and reset control are still separate,
are they not?

>> Allwinner sources list this block as "R_PIO". I suggest using this name.
>> Clearly "pioL" does not cover all the functionality.
>
> I'd agree with that.
>
>
>> I have started to document the PRCM block: http://linux-sunxi.org/PRCM
>
> It's quite different on the A31 and on the A23 actually :(
>
> You don't have any of the audio thing for example, but you have the
> CPUs power clamp controls, that have been removed in the A23.

Thank you for bringing this up. I went through the code and updated
these bits on the wiki. The CPU power clamps are interleaved throughout
the PRCM registers :(


Cheers,
ChenYu
