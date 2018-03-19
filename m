From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 19 Mar 2018 14:26:33 +0100
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
In-Reply-To: <20180319131804.GD2743@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
 <20180319131009.GJ4519@kwain>
 <20180319131804.GD2743@n2100.armlinux.org.uk>
Message-ID: <20180319132633.GL4519@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Mar 19, 2018 at 01:18:05PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2018 at 02:10:09PM +0100, Antoine Tenart wrote:
> > 
> > On 7k/8k you have the following scheme for 10G only interfaces:
> > 
> >    MAC -- Comphy -- PHY -- SFP cage -- ...
> > 
> > Or
> > 
> >    MAC -- Comphy -- SFP cage -- ...
> > 
> > The comphy provides serdes lanes, and can be configured in various
> > modes (SGMII, 2500SGMII, 10GKR...).
> 
> Right - the correct mode is dependent on the SFP module plugged into
> the cage.  Trying to describe this by ignoring the SFP cage isn't
> going to work out well for end-user functionality, though is fine if
> you're just hacking a configuration to test (which would not be
> suitable for mainline kernels!)
> 
> As I've recently replied to Yan, this is a configuration I haven't
> tested yet, and it's entirely possible that phylink may need some
> tweaks for it.
> 
> What you have is a very similar setup to what is on Clearfog with
> its SFP cage, where the SFP cage is connected directly to the
> Armada 388.  That only has to deal with 2500base-X / 1000base-X /
> SGMII and not 10G.
> 
> What I want is to avoid hacks as much as possible here - if there is
> a short-coming with SFP/phylink here, we need to address that
> properly.

OK. So the proper solution would be to properly describe the SFP cages
in the device tree (and check if phylink deals with it nicely).

I'll update the patches in this way.

Thanks for the feedback,
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
