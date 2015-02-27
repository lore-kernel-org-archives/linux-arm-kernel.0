From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 14:07:42 +0100
Subject: [PATCH 1/2] arm64: juno: Add APB registers and LEDs using syscon
In-Reply-To: <20150225151157.GC905@e106497-lin.cambridge.arm.com>
References: <1424866589-2988-1-git-send-email-linus.walleij@linaro.org>
 <20150225135512.GE12377@arm.com>
 <20150225144756.GA905@e106497-lin.cambridge.arm.com>
 <20150225150023.GJ12377@arm.com>
 <20150225151157.GC905@e106497-lin.cambridge.arm.com>
Message-ID: <CACRpkdYd7ZOMt1QxhCxzhavhcd8wcWrC2j1Ce5eGP9piX=xwkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 4:11 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Feb 25, 2015 at 03:00:23PM +0000, Will Deacon wrote:
>> On Wed, Feb 25, 2015 at 02:47:56PM +0000, Liviu Dudau wrote:
>> > On Wed, Feb 25, 2015 at 01:55:12PM +0000, Will Deacon wrote:
>> > > On Wed, Feb 25, 2015 at 12:16:29PM +0000, Linus Walleij wrote:
>> > > > This defines the Juno "APB system registers" as a syscon device,
>> > > > and all the LEDs controlled by the APB system registers right
>> > > > below it using the syscon LEDs driver on top of syscon. Define
>> > > > LED0 for heartbeat, LED1 for MMC0 activity and the following
>> > > > four LEDs indicating CPU activity using the Linux-specific
>> > > > DT bindings for triggers.
>> > > >
>> > > > This is the pattern and same drivers as used on the legacy
>> > > > platform device trees for the ARM Integrators and the RealView
>> > > > PB1176.
>> > >
>> > > Stupid question, but where are these LEDs located on the platform? I tried
>> > > enabling this, but all it seemed to do was make hackbench slightly slower :)
>> >
>> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0524c/deb1353593789871.html
>> >
>> > Section 1.3, look at the left hand side, above the user push buttons.
>>
>> Right, so these LEDs are *inside* the case. Is that really something worth
>> enabling for defconfig?
>
> Depends on the case :) You might have a nice cutout in the plastic of the VExpress
> box, or have your own custom acrylic box.

Of course I take off the lid, who doesn't want to see the nice electronics.
This is analogous to using some other naked ARM reference design
like the Versatile or the RealView PB1176 where you can just put your
fingers on the board if you like.

> Maybe Linus can explain to us why he thinks this functionality is useful given
> that quite a lot of people tend to use the Juno boards inside the original boxes
> for fear of ESD accidents.

Wut? Ask the guy who designed the box.

Notice that the SD card slot is *ALSO* inside the box, do you mean we
should then also delete the uSD card support added in
commit 71f867ec130e3cc8e692366fdf8941ded27c727e
by yourself because the SD card slot is not reachable?
Notice that to access that card slot you even have to remove the
nice blue ARM boilerplate.

The board is obviously designed to be reachable and the top part
of the case is obviously designed to be taken off by professional
users.

Yours,
Linus Walleij
