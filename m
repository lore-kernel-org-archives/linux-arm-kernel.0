From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  9 Dec 2013 16:34:44 -0800
Subject: [PATCH 0/2] clockevents
In-Reply-To: <alpine.DEB.2.02.1312071151340.30673@ionos.tec.linutronix.de>
References: <alpine.DEB.2.02.1312071151340.30673@ionos.tec.linutronix.de>
Message-ID: <1386635686-15686-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

before respinning the complete series, I thought we could take a look at
the changes to the timer core, since I expect them to need to be refined
for an actual submission.

The first patch is the patch you proposed to serialize callers of
clockevents_update_freq(). I guess you may find some better words to
describe your changes. I found it not that easy to find a nice
description for somebody else's patch.

The second patch is my shot at extending clockevents_update_freq()
to also handle timers in periodic mode. In my approach I assume that
simply calling the timer's 'set_mode()' API takes care of programming an
appropriate interval based on the current timer frequency. If that
doesn't work for all timers, I guess it would require a new API call. Or
I just missed some other way.

	Thanks,
	S?ren

Soren Brinkmann (2):
  time: Serialize calls to 'clockevents_update_freq' in the timing core
  time: clockevents: Adjust timer interval when frequency changes

 kernel/time/clockevents.c    | 32 +++++++++++++++++++++++++-------
 kernel/time/tick-broadcast.c | 25 +++++++++++++++++++------
 kernel/time/tick-internal.h  |  4 ++++
 3 files changed, 48 insertions(+), 13 deletions(-)

-- 
1.8.5.1
