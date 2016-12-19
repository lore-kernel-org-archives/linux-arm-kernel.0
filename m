From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Dec 2016 16:00:08 +0100
Subject: [PATCH 1/4] net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to
 be used at address 0x1
In-Reply-To: <292d4f15-c58b-3565-26ec-98a025b6adb3@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-2-romain.perier@free-electrons.com>
 <20161219143848.GA10048@lunn.ch>
 <292d4f15-c58b-3565-26ec-98a025b6adb3@free-electrons.com>
Message-ID: <20161219150008.GE10048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 03:56:34PM +0100, Romain Perier wrote:
> Hi Andrew,
> 
> Le 19/12/2016 ? 15:38, Andrew Lunn a ?crit :
> >On Mon, Dec 19, 2016 at 03:16:06PM +0100, Romain Perier wrote:
> >>Currently, the function mv88e6xxx_smi_init() returns -EINVAL if the bit
> >>zero of sw_addr is 0x1. However, on some platforms, ethernet switches
> >>are configured in Multi chip addressing mode and available at MDIO
> >>address 0x1.
> >
> >Hi Romain
> >
> >What branch is this against? net-next?
> 
> Until last friday it was based onto next-20161216, I rebased onto
> the torvalds's tree this morning (so ~4.10-pre-rc1).

This patchset is 80% networking. So please see:

Documentation/networking/netdev-FAQ.txt

> Oh, it's already fixed, good. I did not see this patch :)
> 
> >
> >It would be nicer to use Volodymyr, since it has been reviewed.
> 
> 
> As the fix is already there, I will use it, sure.

Im not sure what happened to it. It might of fallen through the
cracks. Lets see what Volodymyr says. It might need resubmitting once
netdev reopens.

       Andrew
