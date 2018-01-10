From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jan 2018 16:45:18 +0000
Subject: [PATCH v2 2/6] arm: Invalidate BTB on prefetch abort outside of
 user mapping on Cortex A8, A9, A12 and A17
In-Reply-To: <20180108185533.9698-3-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-3-marc.zyngier@arm.com>
Message-ID: <20180110164518.GO17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 06:55:29PM +0000, Marc Zyngier wrote:
> In order to prevent aliasing attacks on the branch predictor,
> invalidate the BTB on CPUs that are known to be affected when taking
> a prefetch abort on a address that is outside of a user task limit.

Can you please describe to me what sort of exploit this is supposed
to be protecting against - if you do not wish to make the details
public, please reply in private.

As far as I can see, this has no effect on the exploits that have been
made public to date as none of them involve the prefetch abort handler,
and from what I can see in the "Cache Speculation Side-Channels"
document, no mention is made of the prefetch abort.

Indeed, I've received feedback from Florian that my set of "exploits"
based on the published information to date are unaffected by your
patch series, so I'm really interested to know exactly what this
series is trying to fix.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
