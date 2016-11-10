From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 10 Nov 2016 01:09:23 +0100
Subject: [PATCH v2] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <4e332daa-7d2a-1481-c8fc-7119033b68e3@axentia.se>
References: <20161020153535.7e2b4frcukk2ce2i@piout.net>
 <4e332daa-7d2a-1481-c8fc-7119033b68e3@axentia.se>
Message-ID: <20161110000923.ltpouekbkx7onzm7@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2016 at 00:41:37 +0100, Peter Rosin wrote :
> On 2016-10-20 15:35, Alexandre Belloni wrote
> > On 16/10/2016 at 18:21:45 +0200, Sylvain Rochet wrote :
> >> Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
> >> pullup is pointless.
> >> 
> >> Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
> >> floating and so consuming a useless extra amount of power in crowbarred
> >> state if nothing is externally connected to dbgu.
> >> 
> >> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> >> ---
> >>  arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
> >>  arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
> >>  arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
> >>  arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
> >>  arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++--
> >>  arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
> >>  arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
> >>  arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
> >>  arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
> >>  arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
> >>  10 files changed, 20 insertions(+), 20 deletions(-)
> >> 
> > Applied, thanks.
> 
> I can't seem to find this patch in any of the repos I'm looking at,
> so I'm wondering where it was applied and when it might hit mainline?
> 

It is applied there:
http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/log/?h=at91-dt

It will land in 4.10. I'll do the PR to arm-soc soon.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
