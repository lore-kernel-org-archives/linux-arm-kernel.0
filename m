From: stefanc@marvell.com (Stefan Chulski)
Date: Wed, 3 Jan 2018 18:26:27 +0000
Subject: [EXT] Re: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable
 the fourth network interface
In-Reply-To: <20180103175446.GI28752@n2100.armlinux.org.uk>
References: <20171228182739.GH2626@kwain>
 <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
 <20171229113850.GX10595@n2100.armlinux.org.uk>
 <CAPv3WKcFT5YgvwEk9QNB5=O0j23ds1jCxaBYnMVhxDHeBZzbDA@mail.gmail.com>
 <20171230173157.GC10595@n2100.armlinux.org.uk>
 <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
 <616c2f3b0fe64184bc26d2de43442540@IL-EXCH01.marvell.com>
 <20180101132520.GB28752@n2100.armlinux.org.uk>
 <0e95e9b20e2d42bc95e04034bd88e781@IL-EXCH01.marvell.com>
 <20180103175446.GI28752@n2100.armlinux.org.uk>
Message-ID: <47d9fdb3b11f4f5cbdb58cc85f0d7875@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sorry, I find this very confusing.
> 
> It seems we have some people telling me that when there's no PHY described
> in DT, we use this link interrupt, and have a functional network interface
> (presumably at whatever speed.)

I give you couple of examples when we have functional network interface with
link interrupt:

1) 10G XLG mode without PHY - since XLG doesn't have auto negation mechanism
2) SGMII with in-band  auto negation
3) RGMII with auto negation done previously by boot loader or by change default fixed
    speed same as speed on cable.

Of course correct way to do it in RGMII mode is use values provided by phylink/phylib.

Stefan.

> 
> I can't see this working from what you describe - what you describe basically
> tells me that when in-band autonegotiation is disabled, and we have no PHY in
> the kernel, then effectively we are in fixed-link mode - since we need to know
> what speed, duplex and flow control settings to use.
> 
> So, this means that mvpp2 should be enforcing the presence of a fixed-link
> description in DT if there is no PHY node at the moment, but it doesn't.
> 
> Instead, it looks to me like the speed and duplex settings are inherited from the
> boot loader or whatever was running before - I can't find anything that
> configures MVPP2_GMAC_AUTONEG_CONFIG in this case.  That seems quite a
> mess.
> 
> Maybe I'm missing something, but I don't see how mvpp2 can be converted to
> phylink given this without causing some kind of regression, unless someone can
> be much clearer about exactly what kinds of link mvpp2 supports and how they
> work (which is basically what I asked back in
> October.)
> 
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
