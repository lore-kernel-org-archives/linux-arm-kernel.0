From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Nov 2010 09:38:26 -0000
Subject: [PATCH 0/5] ARM: perf: split up perf_event.c by architecture
In-Reply-To: <AANLkTikh9k7RmLc_S4FHD+-OnN6aS9d0GPv1gcpjof1A@mail.gmail.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<AANLkTikh9k7RmLc_S4FHD+-OnN6aS9d0GPv1gcpjof1A@mail.gmail.com>
Message-ID: <005501cb8572$058fb0a0$10af11e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean, Jamie,

> Will,
> 
> On Mon, Nov 15, 2010 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Jean - is this a sensible email address to contact you with? Your old
> >       mvista one has stopped working.
> Yes this one is the new one to use.

Great - would you like me to update the copyright notice in perf_event_v7.c
so that it uses your new address?
 
> >
> > Our perf_event.c is becoming rather cumbersome as more PMUs are added.
> > I know of at least two more (v7-based) PMUs that will be added in the
> > coming months which will push this file to the ~4KLOC region.
> >
> > Since most updates to this file are to do with changes to the generic
> > Linux perf API, let's do what x86 does and split out the separate PMU
> > implementations into their own files. I've chosen to split it by
> > architecture revision: xscale, v6 and v7. Since the v7 PMU registers
> > are architected, this means that new v7 implementations just need to
> > describe their event mappings.
> 
> That makes sense!
> 
> >
> > Comments welcome.
> >
> > Cc: Jamie Iles <jamie.iles@picochip.com>
> > Cc: Jean Pihet <jean.pihet@newoldbits.com>
> 
> Thanks!
> 

Thanks for the feedback I've had so far, I'll go through and
address the issues inline. Note that patch 5/5 is *huge* because
it moves code out of perf_event.c. This means that it's been held
for moderation on the list because of its size.

Will
