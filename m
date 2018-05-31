From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 May 2018 06:41:09 -0700
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <20180531040638.GA26751@rob-hp-laptop>
 <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
Message-ID: <20180531134109.GJ5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 11:27]:
> On Thursday 31 May 2018 09:36 AM, Rob Herring wrote:
> > On Wed, May 30, 2018 at 07:41:32PM +0530, Faiz Abbas wrote:
> >> --- a/arch/arm/boot/dts/dra76x.dtsi
> >> +++ b/arch/arm/boot/dts/dra76x.dtsi
> >> @@ -11,6 +11,25 @@
> >>  / {
> >>  	compatible = "ti,dra762", "ti,dra7";
> >>  
> >> +	ocp {
> >> +
> >> +		target-module at 0x42c00000 {
> > 
> > Build your dtb with W=1 and fix warnings you add (drop '0x').
> 
> Sure, Will fix this.
> > 
> > This is a CAN bus controller? If so, then use 'can' for node name.
> 
> Yes but I am using m_can along the lines of dcan in other boards (For
> example, see arch/arm/boot/dts/am33xx.dtsi:1046). Are you saying all CAN
> controllers should only be called can?

The module should be target-module at 42c00000 and the child(ren)
can at 1a00 or mcan at 1a00 if mcan is different from can.

Regards,

Tony
