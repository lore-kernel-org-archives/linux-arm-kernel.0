From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 10:54:15 -0700
Subject: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default
 uart pads
In-Reply-To: <87r4uv51rz.fsf@ti.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
 <87397uhv0q.fsf@ti.com>
 <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
 <20120504172417.GE5613@atomide.com> <87r4uv51rz.fsf@ti.com>
Message-ID: <20120507175414.GH5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120507 10:42]:
> Tony Lindgren <tony@atomide.com> writes:
> >  
> > Just to follow up on this.. Let's first get things working reliably,
> > and only then add more PM support.
> >
> > We absolutely can't revert $SUBJECT because it's known to mess up
> > at least smsc911x and ehci on zoom3, hsi on n900 and probably
> > many other things.
> >
> > For the -rc cycle, it seems that [2] is out of question at this point
> > as too intrusive. If the PM & wakeups are broken in the default cases,
> > then I suggest we just take few steps back and disable any deeper PM
> > states in the -rc series.
> 
> Unfortunately, no need to do anything more to disable deeper PM states.
> 
> Because $SUBJECT disables runtime PM for UART, it keeps both PER and
> CORE on all the time. :(

Oh well, it seems that that runtime PM can now be enabled on per-board
basis as it gets tested.

Regards,

Tony
