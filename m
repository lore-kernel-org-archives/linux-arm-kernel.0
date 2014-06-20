From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 09:15:09 +0100
Subject: [PATCH v2] clocksource: exynos-mct: Register the timer for
 stable udelay
In-Reply-To: <53A31291.9000007@gmail.com>
References: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
 <53A2B9C3.1050906@gmail.com>
 <CAD=FV=VmC-p4_R1GV3U3bg1JojTzNYKyFTa8o8QMJ=3m=WuRYA@mail.gmail.com>
 <53A30D08.6070107@gmail.com>
 <CAD=FV=UjFJ9utR9i=Xu4DRQ7gdULCtXQXgsQ8gUYm6-V5U4GaQ@mail.gmail.com>
 <53A31291.9000007@gmail.com>
Message-ID: <20140620081509.GA25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 05:40:49PM +0100, Tomasz Figa wrote:
> On 19.06.2014 18:31, Doug Anderson wrote:
> >>> My personal vote would be to submit a patch to change "cycles_t" to
> >>> always be 32-bits.  Given that 32-bits was fine for udelay() for ARM
> >>> that seems sane and simple.  If someone later comes up with a super
> >>> compelling reason why we need 64-bit timers for udelay (really??) then
> >>> they can later add all the complexity needed.
> >>
> >> Yes, this could work. I'm not sure what else cycles_t is used for, though.
> > 
> > True, it is a bit questionable to change this since it's a type that's
> > not obviously just for udelay().  Perhaps a better option would be to
> > make a new typedef for the result of read_current_timer().  ...or just
> > change it to return a u32?
> > 
> 
> Sounds good to me, but let's hear other opinions. I'm adding Will and
> Jonathan as they wrote the ARM delay timer code.

I think cycles_t is only used for small interval calculations at the moment,
but I remember Ted mentioning something about using it (or something
similar) as a source of early entropy, in which case the more bits the
better.

That said, I can't find any code in the tree to that effect.

Will
