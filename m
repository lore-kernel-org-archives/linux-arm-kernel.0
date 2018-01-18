From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 18 Jan 2018 16:06:44 +0100
Subject: [PATCH net-next v5 0/4] net: mvpp2: 1000BaseX and 2500BaseX
 support
In-Reply-To: <20180116151245.GJ17719@n2100.armlinux.org.uk>
References: <20180112075130.30890-1-antoine.tenart@free-electrons.com>
 <20180116151245.GJ17719@n2100.armlinux.org.uk>
Message-ID: <20180118150644.GH2690@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 16, 2018 at 03:12:45PM +0000, Russell King - ARM Linux wrote:
> 
> As I've already said, we need to make sure things are done in a similar
> way for all netdev DT drivers that are hoping to switch to phylink.
> The mvneta patches are now in net-next for this.
> 
> What I can see is that there's a stark difference between mvpp2 and
> mvneta and their handling of the "link irq" aka inband autonegotiation
> status.
> 
> mvneta requires 'managed = "in-band-status";' to use the results of
> the gmac negotiation otherwise inband AN is disabled.  As phylink was
> developed against mvneta, phylink requires that for Base-X modes.
> 
> So, in order to be compatible with mvneta and to do what phylink expects,
> specifying 'managed = "in-band-status";' is a requirement for Base-X
> modes, and having that in place _now_ will make the transition to
> phylink easier without creating the need to update DT when that change
> happens.

Yes, we should aim for similar bindings and not having all drivers doing
their own way. Part of the PPv2 move to phylink will be to rework the
"link irq" to match what phylink expect, and I think we all agree on
this. Part of this will be to update the dt of the 7k-db and 8k-db, as
they're the two boards currently using the "link irq" in mainline.

I don't mind too much keeping these base-X patches out-of-tree for now,
and to send them as part of the phylink series during the next cycle.

I don't quite get the reason not to take them now, as they do not
modify any DT-related part. Or do you fear this would allow others to
send DT patches before the PPv2 move to phylink lands in?

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
