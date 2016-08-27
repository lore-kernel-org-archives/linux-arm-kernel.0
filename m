From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Aug 2016 13:42:51 +0100
Subject: [PATCH] pcmcia: ds: fix suspend/resume
In-Reply-To: <20160827120522.GA3933@light.dominikbrodowski.net>
References: <E1bbFKU-0001OO-RA@rmk-PC.armlinux.org.uk>
 <20160827120522.GA3933@light.dominikbrodowski.net>
Message-ID: <20160827124251.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 02:05:22PM +0200, Dominik Brodowski wrote:
> Russell,
> 
> On Sun, Aug 21, 2016 at 12:05:30AM +0100, Russell King wrote:
> > PCMCIA suspend/resume no longer works since the commit mentioned below,
> > as the callbacks are no longer made.  Convert the driver to the new
> > dev_pm_ops, which restores the suspend/resume functionality.  Tested on
> > the arm arch Assabet platform with a pcnet_cs CF card.
> > 
> > Fixes: aa8e54b559479 ("PM / sleep: Go direct_complete if driver has no callbacks")
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Looks goot to me. Can you push it upstream, please?

I can do - should I take that as an Acked-by?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
