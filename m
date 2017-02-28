From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 28 Feb 2017 19:56:44 +0100 (CET)
Subject: [PATCH v3 04/25] clocksource: Add Owl timer
In-Reply-To: <1e3b84be-12f5-bde7-a54d-e9ce835e4001@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-5-afaerber@suse.de> <20170228164745.GC30601@mai>
 <1994faec-7936-aa96-87b4-df48f75f179b@suse.de> <20170228173950.GD30601@mai>
 <1e3b84be-12f5-bde7-a54d-e9ce835e4001@suse.de>
Message-ID: <alpine.DEB.2.20.1702281953350.4007@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Feb 2017, Andreas F?rber wrote:
> This is a callback, which I thought is re-entrant.

It's not reentrant at least not on the same CPU. On a SMP machine this
function might be called concurrently on several cores (assumed that the
whole thing is replicated across cores).

> VAL changes when the timer is running, and CTL changes every time we
> enable the timer. We could call _reset() here, but then we would be
> initializing CMP twice, which again would be less performant then just
> setting the registers to their final values directly.

Makes sense.

Thanks,

	tglx
