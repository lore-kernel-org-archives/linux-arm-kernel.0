From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 03:26:50 -0700
Subject: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
In-Reply-To: <87li69qdcs.fsf@lebrac.rtp-net.org>
References: <20130612163124.GD8164@atomide.com>
 <20130612171407.GM8164@atomide.com> <51B98F1E.1000006@ti.com>
 <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com> <87ppvlqhyy.fsf@lebrac.rtp-net.org>
 <20130617082458.GH20992@atomide.com>
 <87li69qdcs.fsf@lebrac.rtp-net.org>
Message-ID: <20130617102650.GK20992@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [130617 02:52]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> I understand your concerns but, please, cope with reality: the clock
> work is not in -next so this tends to make me think it won't reach
> 3.11. We're at -rc6 after all. Telling users that their system doesn't
> have any network because it was easier to maintain, is not something
> they will understand imho.

Right, like I said: the idea is to have it usable with DT. And USB and
Ethernet certainly are part of what I call usable. So is MMC, WLAN and
DSS. I've certainly spent quite a bit of time on making sure panda works
with DT, and I can assure you that fixing the USB extclock is easier than
supporting the legacy boot with DT :)

This issue can also be fixed with a clock alias if we don't have DT
defined clocks ready for v3.11. It may take a few days for us to have
the solution. But get getting a clock to a driver certainly is not a
showstopper here. After all, that's what all drivers already do.

Regards,

Tony
