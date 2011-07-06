From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:16:00 +0100
Subject: [PATCH 00/17] Introduce a led trigger for CPU activity
In-Reply-To: <CAMPhdO-Ln7BmU8jYfEEp3RPa9sgJueTVfsm1phs=NXTC3FPgNw@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAMPhdO-Ln7BmU8jYfEEp3RPa9sgJueTVfsm1phs=NXTC3FPgNw@mail.gmail.com>
Message-ID: <20110706131600.GW8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 09:13:14PM +0800, Eric Miao wrote:
> > ?drivers/leds/ledtrig-cpu.c ? ? ? ? ? ? ? ? ? ? | ?144 ++++++++++++
> > ?include/linux/leds.h ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 15 ++
> > ?105 files changed, 1532 insertions(+), 3119 deletions(-)
> 
> Not bad, I like the numbers here. This is definitely a good move.
> I had long ago wanted to remove those legacy LED code in mach-pxa.

The down-side is that through these moves we've lost functionality each
time.  For example, the blinking heartbeat LED on the Assabet and
Netwinder which I always enabled to let me know whether the machines
were still alove has long since gone.

I hope that this series restores that functionality on those platforms
where it has been lost.
