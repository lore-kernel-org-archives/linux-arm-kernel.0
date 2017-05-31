From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Wed, 31 May 2017 14:26:14 +0200
Subject: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <CACQ1gAhhVEem9=We3mTJwhDbLDNw+_uyr2LpAyjQSk0iJ4O6Ew@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-2-ralph.sennhauser@gmail.com>
 <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
 <87tw42tqdr.fsf@free-electrons.com>
 <20170530165101.73ae0bf6@gmail.com>
 <CACQ1gAhhVEem9=We3mTJwhDbLDNw+_uyr2LpAyjQSk0iJ4O6Ew@mail.gmail.com>
Message-ID: <20170531142614.5f32fca6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 May 2017 17:35:33 +0200
Richard Genoud <richard.genoud@gmail.com> wrote:
  
> Hi Ralph,
> 
> I have the functional spec (no NDA needed, but it's not the full
> one) : A38x-Functional-Spec-PU0A.pdf
> https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
> (just an email needed, no blood signing nor chicken slaughtering)
> There are the GPIO Blink Counter A/B is ON/OFF Duration Registers as
> well as the Blink Enable Registers.
> 

Hi Richard,

Thanks for the link, as the terms only talk about materials obtained
from www.marvell.com this one from wufoo.com should be exempt ;)
Also at a glance looks like the complete one. Also says "Functional
Specifications ? Unrestricted". Maybe you want to re-download it.

Regardless, as you said the blinking registers are all described. So
it's probably safe to assume 39x will have them as well.

> I've done a pwm with different periods (8ms, 4ms, 100ns).
> Looking at the scope, it seems to work pretty well :)
> 
> >>
> >> And it makes me realized that I missed the bad naming of the
> >> compatible string. We don't use family name for the compatible
> >> string, but the name of the first SoC compatible with. So in this
> >> case we should use "marvell,armada-370", as it is still in rc and
> >> not yet deployed. What about fixing the name now?  

Gregory,

Knowing it's not limited to 370/XP makes "marvell,armada-370-gpio" an
obviously better choice for the compatible string. Guess you didn't
mean to drop the "-gpio" suffix.

Will work on a patch changing the compatible string / documentation for
4.12 and an updated patch for armada 370/XP dtsi as well as a patch
adding the properties to 38x for 4.13+. Expect them tomorrow, probably
won't get around to it today anymore.

Ralph
