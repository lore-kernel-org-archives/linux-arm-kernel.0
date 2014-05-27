From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 21:27:06 +0200
Subject: [PATCH] arm: Set hardirq tracing to on when idling
In-Reply-To: <5384DF47.2070904@codeaurora.org>
References: <1401045323-7116-1-git-send-email-minyard@acm.org>
 <4475199.26Fs5MKAfh@wuerfel> <5384DF47.2070904@codeaurora.org>
Message-ID: <6082113.tHepRBe99K@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 May 2014 11:53:59 Stephen Boyd wrote:
> On 05/27/14 11:49, Arnd Bergmann wrote:
> >
> > You also commented in that thread about stop_critical_timings()/
> > start_critical_timings(). Corey, can you look at that, too? I
> > think it's designed to avoid the issue you are seeing but
> > for some reason doesn't.
> 
> I sent a patch last week to "solve" this problem. I'm not sure if it's
> right but it works for me.
> 
> https://lkml.org/lkml/2014/5/19/607

I think that one was also wrong, as the intention of the existing
stop_critical_timings() function is already to do the same that
Corey's patch does, i.e. stop the trace before we go to idle as
if we were turning IRQs on.

Corey, does it work for you if you replace the new trace_hardirqs_on()
you added with time_hardirqs_on() or stop_critical_timing()?

	Arnd
