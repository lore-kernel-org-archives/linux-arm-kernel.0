From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 8 Jan 2013 13:32:11 -0000
Subject: [PATCH 1/1 net-next] net: fec: enable pause frame to improve rx
 prefomance for 1G network
In-Reply-To: <1357649564.29986.10.camel@deadeye.wl.decadent.org.uk>
References: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
 <1357649564.29986.10.camel@deadeye.wl.decadent.org.uk>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7104@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If the medium supports autoneog, use mii_advertise_flowctrl() in
> set_pauseparam to update pause frame advertising and then restart
> autoneg.

Isn't autoneg continuous?
In which case you just need to monitor the response register.
Monitoring MII registers is usually a complete PITA though
(due to the requirements for delays during the bit-bashing).

	David
