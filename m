From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 9 Sep 2015 08:48:06 +0200
Subject: [PATCH v2 1/3] ARM: Make FORCE_MAX_ZONEORDER configurable if
 ARM_SINGLE_ARMV7M
In-Reply-To: <20150908221912.GE21084@n2100.arm.linux.org.uk>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1441744686-20521-2-git-send-email-mcoquelin.stm32@gmail.com>
 <20150908221912.GE21084@n2100.arm.linux.org.uk>
Message-ID: <CALszF6CqVfTNSiSK39oP=zNU5Ne5V++0mD1n0HGhJ_+GMqeadw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-09 0:19 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Sep 08, 2015 at 10:38:04PM +0200, Maxime Coquelin wrote:
>> This patch makes FORCE_MAX_ZONEORDER configurable in defconfig for ARMV7-M
>> when built for a single platform.
>
> I'd prefer if we didn't do this, because this isn't supposed to be a user
> visible "option".  It's an option that was introduced to avoid having to
> throw masses of #ifdefs into the definition of MAX_ZONEORDER.
>
> The problem with it is that it's a "well, what do I set this to?" option
> and that leads to "oh, I'll just choose the default because I don't know
> any better".
>
> Do we know why EFM32 needs a value of 9 here?  It's not documented in
> the original commit, and it really _should_ have been.
Ok, I get your point.

For STM32, the value 11 is working, but having value of 9 makes sense
in my opinion for systems with small quantity of memory (8MB in the
case of STM32F429 Discovery).
It saves some bytes in the .data section, and it might also save some
CPU cycles as there are less iterations and less split/coalescing of
pages...
Note that for CPU cycles I haven't done any measurements, this is just
my opinion after code review.

What drawbacks do you see of using a value of 9?

Thanks,
Maxime
