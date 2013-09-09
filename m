From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 16:21:01 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
Message-ID: <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, Sep 7, 2013 at 1:21 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 4, 2013 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> (...)
>>  arch/arm/mach-shmobile/clock-r8a7791.c        |  198 +++++++++++++++++++++++++
>
> So what about starting afresh by letting this new SoC use the
> generic clk framework in drivers/clk from day one instead of
> adding another chunk of custom clk code to the kernel?

I agree that we should use common clocks as soon as ever possible, but
as you can see in the actual patch, Nakamura-san has already written
code using the old framework. So unless you have a time machine... =)

The use of legacy clocks has happened because we so far haven't done
enough upfront development of Renesas-specific clock hardware drivers
for CCF. So it's understandable that SoC-specific code is written
towards already existing code. At the same time I agree that blindly
sticking to legacy code can't work, so yes, we need to work on CCF.

Fortunately there are plans to convert several mach-shmobile SoCs to
common clocks over the next 6 months. As you know, we spent much time
and efforts converting to pinctrl last two 6 month periods, and now we
will be targeting common clocks.

> (There may be reasons for this, but I have to ask the
> inevitable question.)

The reason why you see a new SoC with legacy clock code is that we
have to add support for the new hardware when it is being released.
The hardware development schedule does unfortunately not follow the
upstream release schedule. =) (yet) So when a new SoW needs software
support we write support towards whichever latest frameworks that we
support. In parallel with this we consolidate and move over to new
frameworks. It is all happening in public and we use source control we
can track history if things fail.

Hope this clarifies!

/ magnus
