From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 11 Apr 2013 10:51:58 -0600
Subject: [PATCHv2 08/10] arm: kirkwood: convert QNAP TS219 to use DT for
 the PCIe interface
In-Reply-To: <20130411052432.GP13524@lunn.ch>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130411003301.GH28693@titan.lakedaemon.net>
 <20130411052432.GP13524@lunn.ch>
Message-ID: <20130411165158.GA5865@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 07:24:32AM +0200, Andrew Lunn wrote:
 
> I've hacked around with PCI driver on my QNAP TS119P+, which does not
> have any PCI devices, and never had any problems with the driver
> enabled and finding two empty PCI busses. PCI does not share any pins
> with anything else. So i think it is safe to just enable it for all
> devices.

In the general case, this is probably only safe if the board has
configured the PEX to have the PHY clock. Marvell has guidelines for
unused PEX's that would result in the PHY clock being permanently
inactive.

Register 10030 tells what the strap for the PHY clock is. I expect in
many cases the PEX driver should not be loaded if the PHY clock is not
internally derived. Maybe checking this register will tell your QNAPs
apart?

Jason
