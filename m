From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 09:50:08 +0000
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <1490001575.2895.8.camel@pengutronix.de>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
 <1489582989.16018.4.camel@pengutronix.de>
 <20170315140541.GT21222@n2100.armlinux.org.uk>
 <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
 <1490001575.2895.8.camel@pengutronix.de>
Message-ID: <20170320095007.GE21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 10:19:35AM +0100, Lucas Stach wrote:
> Yes, probably we want to have both at some point. The cooling-device
> stuff is about throttling the GPU when the SoC reaches critical
> temperatures.
> 
> The devfreq governors are about providing exactly the right performance
> point.
> Though as I have not yet seen any SoCs where the voltage would be scaled
> with GPU frequency, downclocking the GPU is of limited value. For most
> of those SoCs a race-to-idle policy is probably okay, as this allows
> other components of the system like the DRAM to go into lower power
> operating modes when the GPU is idle.

However, since we already have runtime PM support in etnaviv (where we
even power the GPU off on some SoCs) the lack of voltage scaling does
suggest that GPU frequency scaling would be of limited value in terms
of overall power usage.

It's also worth bearing in mind that Vivante GPUs internally control
clock gates to various modules when they're on.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
