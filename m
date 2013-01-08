From: bhutchings@solarflare.com (Ben Hutchings)
Date: Tue, 8 Jan 2013 13:57:27 +0000
Subject: [PATCH 1/1 net-next] net: fec: enable pause frame to improve rx
 prefomance for 1G network
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7104@saturn3.aculab.com>
References: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
 <1357649564.29986.10.camel@deadeye.wl.decadent.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7104@saturn3.aculab.com>
Message-ID: <1357653447.29986.15.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-08 at 13:32 +0000, David Laight wrote:
> > If the medium supports autoneog, use mii_advertise_flowctrl() in
> > set_pauseparam to update pause frame advertising and then restart
> > autoneg.
> 
> Isn't autoneg continuous?
> In which case you just need to monitor the response register.
> Monitoring MII registers is usually a complete PITA though
> (due to the requirements for delays during the bit-bashing).

AIUI you have to break the link before renegotiating.  So you should
only need to read autoneg results after a PHY interrupt or polling for a
link change.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
