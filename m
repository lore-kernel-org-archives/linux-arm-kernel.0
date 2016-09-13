From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 13 Sep 2016 15:15:23 +0100
Subject: [PATCH 6/8 v2] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <20160913123639.GB15332@lunn.ch>
References: <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
 <1473109646-23366-1-git-send-email-jm@lentin.co.uk>
 <20160912170625.GA7420@rob-hp-laptop> <2920481.EgEQnLmOkM@wuerfel>
 <20160912220344.GM11400@lunn.ch>
 <88e40f0c6cafec244dc16af5a03cfb44@jamie.lentin.co.uk>
 <20160913123639.GB15332@lunn.ch>
Message-ID: <b7d442f9d26249976d7698b6a32db2a3@jamie.lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-13 13:36, Andrew Lunn wrote:
> On Tue, Sep 13, 2016 at 10:10:41AM +0100, Jamie Lentin wrote:
>> On 2016-09-12 23:03, Andrew Lunn wrote:
>> >>Maybe we can instead leave out the PCI support from the new
>> >>file for now and not delete the legacy board file?
>> 
>> This seems a reasonable compromise. The PCI card the router comes
>> with isn't supported by mwl8k mainline anyway (There's STA-only
>> firmware that can be extracted from a windows driver and PCI IDs
>> added, but stats reporting uses a different format), so it's not a
>> huge loss, although many did replace the card with something
>> Atheros-based.
> 
> O.K. So dropping the PCI code gets us going forward.

Is an arch/arm/mach-mvebu/orion5x.c also required? Or is continuing to 
use arch/arm/mach-orion5x/board-dt.c until everything has been converted 
the favoured approach?

> Have we missed the merge window?

I got the impression Gregory Clement had merged them? If not a good 
portion of this patchset is uncontroversial generic orion5x stuff, it'd 
be nice to get those in even if none of the router-specific stuff 
doesn't make it.

>> Unfortunately the power regulator on my spare router has stopped
>> regulating, which will make more development tricky.
> 
> The Green Light of death?

Seems that way, the 3.3v line is only getting up to 2.8v. My routers 
have had their power supply sections hacked in comparison to photos I've 
seen on GLOD pages, so I presumed this was fixed. Apparently not. Maybe 
I can persuade it to be useful with 5v + 3.3v in the right places.

>> >Jamie, which interrupt do you see the WiFi card using?  If it is
>> >IRQ_ORION5X_PCIE0_INT, (1 + 11), that is probably easier to deal with
>> >than if it uses GPIO 4.
>> 
>> Definitely uses GPIO 4.
> 
> O.K, that makes it more interesting. As far as i can see, no other
> PCIe system uses a GPIO for its interrupt. There is no core support
> for this, or any bus driver doing it. So there is no binding to
> follow.

Not sure if the difference is relevant at this point but it's regular 
PCI, not PCIe.

> 
> 	Andrew
