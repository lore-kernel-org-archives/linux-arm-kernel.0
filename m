From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 16 Nov 2010 09:32:35 +0100
Subject: [PATCH 0/5] ARM: perf: split up perf_event.c by architecture
In-Reply-To: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTikh9k7RmLc_S4FHD+-OnN6aS9d0GPv1gcpjof1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Mon, Nov 15, 2010 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> Jean - is this a sensible email address to contact you with? Your old
> ? ? ? mvista one has stopped working.
Yes this one is the new one to use.

>
> Our perf_event.c is becoming rather cumbersome as more PMUs are added.
> I know of at least two more (v7-based) PMUs that will be added in the
> coming months which will push this file to the ~4KLOC region.
>
> Since most updates to this file are to do with changes to the generic
> Linux perf API, let's do what x86 does and split out the separate PMU
> implementations into their own files. I've chosen to split it by
> architecture revision: xscale, v6 and v7. Since the v7 PMU registers
> are architected, this means that new v7 implementations just need to
> describe their event mappings.

That makes sense!

>
> Comments welcome.
>
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>

Thanks!


>
> Will Deacon (5):
> ?ARM: perf: consolidate common PMU behaviour
> ?ARM: perf: avoid exposing internal stop function for v6 PMU
> ?ARM: perf: add _init() functions to PMUs
> ?ARM: perf: encode PMU name in arm_pmu structure
> ?ARM: perf: separate PMU backends into multiple files
>
> ?arch/arm/kernel/perf_event.c ? ? ? ?| 2448 +----------------------------------
> ?arch/arm/kernel/perf_event_v6.c ? ? | ?674 ++++++++++
> ?arch/arm/kernel/perf_event_v7.c ? ? | ?906 +++++++++++++
> ?arch/arm/kernel/perf_event_xscale.c | ?809 ++++++++++++
> ?4 files changed, 2423 insertions(+), 2414 deletions(-)
> ?create mode 100644 arch/arm/kernel/perf_event_v6.c
> ?create mode 100644 arch/arm/kernel/perf_event_v7.c
> ?create mode 100644 arch/arm/kernel/perf_event_xscale.c
>
>
