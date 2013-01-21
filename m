From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 15:23:22 -0800
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <20130121210341.GW23505@n2100.arm.linux.org.uk>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de>
 <20130121210341.GW23505@n2100.arm.linux.org.uk>
Message-ID: <20130121232322.GK15361@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130121 13:07]:
> 
> As for Samsung and the rest I can't comment.  The original reason OMAP
> used this though was because the 32768Hz counter can't produce 100Hz
> without a .1% error - too much error under pre-clocksource
> implementations for timekeeping.  Whether that's changed with the
> clocksource/clockevent support needs to be checked.

Yes that's why HZ was originally set to 128. That value (or some multiple)
still makes sense when the 32 KiHZ clock source is being used. Of course
we should rely on the local timer when running for the SoCs that have
them.

Regards,

Tony
