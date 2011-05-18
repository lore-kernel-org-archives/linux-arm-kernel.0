From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 18 May 2011 21:33:39 -0000
Subject: [patch 0/7] clocksources/clockevents improvements
Message-ID: <20110518205713.947614271@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series provides a few improvements to the core code of
clocksources and clockevents.

1) Better layout and cacheline alignment of the hotpath data in both
   data structures

2) Get rid of the hardcoded 5 seconds sleep limit in clocksources

3) Provide a generic configuration and registration interface for
   clockevents which does all the common math tasks so we can remove
   copied code all over the place

4) Provide a function to reconfigure an active clock event
   device. Needed by devices which are affected by frequency scaling.

The last two patches are x86 specific and make use of the new
config_register() functions.

Thanks,

	tglx
