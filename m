From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 3 Oct 2015 10:32:19 +0100
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <yw1xbncgluad.fsf@unicorn.mansr.com>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
 <yw1xbncgluad.fsf@unicorn.mansr.com>
Message-ID: <20151003103219.1e10bdeb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Oct 2015 00:34:02 +0100
M?ns Rullg?rd <mans@mansr.com> wrote:

> Mason <slash.tmp@free.fr> writes:
> 
> > My port requires the TWD to function. So I'm using
> > select HAVE_ARM_TWD (no "if SMP") to have it work
> > even on MULTIPLATFORM UP configs.
> 
> You could just let it use another timer in the non-smp case if you
> didn't have that weird aversion towards using my code.

I have no idea what your code does, but using the timer that is
integrated into the core (just like on any other A9 implementation)
feels like the right thing to do, unless the HW is too broken to use
TWD.

Another timer is a nice thing to have (it probably comes in handy for
suspend/resume, and it may have a much better resolution), but this
seems like icing on the cake at this point. Let's see the cake first.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
