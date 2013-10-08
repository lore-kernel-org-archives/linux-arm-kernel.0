From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Oct 2013 17:31:47 +0200
Subject: [GIT PULL] fixes for integer rounding in timer core (Was: [PATCH v2]
 clockevents: Sanitize ticks to nsec conversion)
In-Reply-To: <5253D9A1.1080106@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253D9A1.1080106@pengutronix.de>
Message-ID: <20131008153147.GR10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> What's the status of this patch?
I pinged Thomas about it already via irc, but I didn't get a response up
to now. It would be great to get that into 3.12. To make it easy for
Thomas, here is a pull request that includes the fix and converts
at91rm9200 back to clockevents_config_and_register dropping one of the
workarounds for the fixed bug.

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/timer-for-tip

for you to fetch changes up to b58c4b70121070f45eefa739ecbb58d57da1c4d9:

  ARM: at91: rm9200: switch back to clockevents_config_and_register (2013-10-08 16:58:22 +0200)

----------------------------------------------------------------
The first patch in this pull request fixes an old integer rounding bug in the
timer core that was (and still is) worked around in a few arch's timer code.
The second patch drops such a work around now that the core is fixed.

----------------------------------------------------------------
Thomas Gleixner (1):
      clockevents: Sanitize ticks to nsec conversion

Uwe Kleine-K?nig (1):
      ARM: at91: rm9200: switch back to clockevents_config_and_register

 arch/arm/mach-at91/at91rm9200_time.c |  7 ++--
 kernel/time/clockevents.c            | 65 +++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 20 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
