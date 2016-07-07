From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Jul 2016 13:48:07 +0800
Subject: [PATCH] arm64: dts: berlin4ct: Add L2 cache topology
In-Reply-To: <577D448D.8030701@gmail.com>
References: <1466066418-1141-1-git-send-email-jszhang@marvell.com>
 <577D448D.8030701@gmail.com>
Message-ID: <20160707134807.08b70b38@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Wed, 6 Jul 2016 19:49:01 +0200 Sebastian Hesselbarth wrote:

> On 16.06.2016 10:40, Jisheng Zhang wrote:
> > This patch adds the L2 cache topology for berlin4ct which has 1MB L2
> > cache.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > index 099ad93..c9e3a98 100644
> > --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi  
> [...]
> > @@ -92,9 +95,14 @@
> >  			device_type = "cpu";
> >  			reg = <0x3>;
> >  			enable-method = "psci";
> > +			next-level-cache = <&L2_0>;
> >  			cpu-idle-states = <&CPU_SLEEP_0>;
> >  		};
> >  
> > +		L2_0: l2-cache0 {  
> 
> Jisheng,
> 
> The node name should just have a generic name that reflects
> the purpose of the unit it represents, i.e.
> s/l2-cache0/cache/

IMHO, "cache" is too generic, this is L2 cache topology, so in v2, I use 
"l2-cache" instead. what do you think?

PS: I found other arm64 SoCs also use "l2-cache" as the node name.

> 
> nits:
> - What is that "0" for? Please remove if there is no good reason.
> - Does the node label need to be upper-case? Please make it lower case.
> 

oh yeah, thanks for the hints! will do in v2.

Thanks for reviewing,
Jisheng

> Sebastian
> 
> > +			compatible = "cache";
> > +		};
> > +
> >  		idle-states {
> >  			entry-method = "psci";
> >  			CPU_SLEEP_0: cpu-sleep-0 {
> >   
> 
