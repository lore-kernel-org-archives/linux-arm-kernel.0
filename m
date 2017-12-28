From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 28 Dec 2017 11:04:16 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171227231959.GU10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171227224252.GB2626@kwain>
 <20171227231959.GU10595@n2100.armlinux.org.uk>
Message-ID: <20171228100416.GD2626@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Dec 27, 2017 at 11:20:00PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 27, 2017 at 11:42:52PM +0100, Antoine Tenart wrote:
> > 
> > What do you suggest to describe this in the dt, to enable a port using
> > the current PPv2 driver?
> 
> I don't - I'm merely pointing out that you're bodging support for the
> SFP cage rather than productively discussing phylink for mvpp2.
> 
> As far as I remember, the discussion stalled at this point:
> 
> - You think there's modes that mvpp2 supports that are not supportable
>   if you use phylink.
> 
> - I've described what phylink supports, and I've asked you for details
>   about what you can't support.

That's not what I remembered. You had some valid points, and others
related to PHY modes the driver wasn't supporting before the phylink
transition. My understanding of this was that you wanted a full
featured support while I only wanted to convert the already supported
modes.

> Unfortunately, no details have been forthcoming, and no further
> discussion has occurred - the ball is entirely in your court to
> progress this issue since I requested information from you and that
> is where things seem to have stalled.
> 
> The result is that, with your patch, you're locking the port to 2.5G
> speeds, meaning that only 4.3Mbps Fibrechannel SFPs can be used with
> the port, and it can only be used with another device that supports
> 2.5G speeds.  You can't use a copper RJ45 module, and you can't use
> a standard 1000base-X module either in this configuration.

You're probably right about not wanting this dt patch. The non-dt
patches still are relevant regardless of phylink being supported in the
PPv2 driver. I'll send a v2 without the dt parts.

Regarding the phylink patch it's stalled for now as I have other
priorities, but I do agree it's a topic that needs to be worked on for a
proper support. I initially made a patch to be nice as it was mentioned
on a previous series, but given the feedback I got I decided to delay it
until my other tasks were completed.

So let's delay the fourth interface support on the mcbin for now.

> What I'm most concerned about, given the bindings for comphy that
> have been merged, is that Free Electrons is pushing forward seemingly
> with no regard to the requirement that the serdes lanes are dynamically
> reconfigurable, and that's a basic requirement for SFP, and for the
> 88x3310 PHYs on the Macchiatobin platform.

The main idea behind the comphy driver is to provide a way to
reconfigure the serdes lanes at runtime. Could you develop what are
blocking points to properly support SFP, regarding the current comphy
support?

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
