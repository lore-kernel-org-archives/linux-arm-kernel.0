From: slash.tmp@free.fr (Mason)
Date: Fri, 15 May 2015 11:29:34 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
References: <55520F0F.5010906@free.fr>
 <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk>
Message-ID: <5555BC7E.7010601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2015 16:42, Russell King - ARM Linux wrote:

> If it's in periodic mode, the update should still be propagated to the
> hardware, assuming the generic time keeping code doesn't produce an
> error.
> 
> twd_update_frequency
> `-clockevents_update_freq
>   `-__clockevents_update_freq
>     `-__clockevents_set_state(, CLOCK_EVT_STATE_PERIODIC)
>       `-dev->set_mode (twd_set_mode)
> 
> That re-writes the TWD_TIMER_LOAD register based on twd_timer_rate,
> which would have been updated by twd_update_frequency().
> 
> The question I posed earlier remains: is clockevents_update_freq()
> failing?  We don't know, because we never check its return value.
> 
> Another thing to look at is whether we reach twd_set_mode().
> 
> Lastly, printing the values of the TWD_TIMER_LOAD and TWD_TIMER_COUNTER
> after twd_set_mode() has written TWD_TIMER_LOAD might provide some
> hints as to what's going on.

I'll have access to the board on Monday.

I'll add printk in strategic places, and report back ASAP.

(I'm considering dropping TWD, and using platform timers.)

Regards.
