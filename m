From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 10 Jul 2016 01:06:08 +0200
Subject: [PATCH 0/3] ARM: dts: the dts support for rk3288 firefly reload
In-Reply-To: <c7f8b96b-ceff-0449-8957-bac2779c9508@soulik.info>
References: <3015470.z4L7UQJKa9@phil> <2686572.mni1Mn7R6t@phil>
 <c7f8b96b-ceff-0449-8957-bac2779c9508@soulik.info>
Message-ID: <5614243.tqTyZoc945@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Samstag, 9. Juli 2016, 23:42:28 schrieb ayaka:
> On 07/08/2016 05:35 AM, Heiko Stuebner wrote:
> > Am Donnerstag, 7. Juli 2016, 02:22:57 schrieb Randy Li:
> >> The rk3288 firefly reload  is a Rockchip RK3288 based board be found by
> >> core board and main board. The regulators are connected in a different
> >> way to the previous version of firefly boards, it is necessary to
> >> move some common code to uncommon place.
> >> 
> >> I only tested the ethernet and confirmed that works.
> >> The usb in this board won't caused by the bugs in the driver.
> >> 
> >> This version follow the suggests from Heiko Stuebner,
> >> except the duplicated supply name problem, I don't think
> >> it could be fixed in that way.
> > 
> > I've now had a chance to look at that reload board on the firefly site.
> > Firefly also is the company name, so a board named that way is not
> > necessarily a "variant" :-) .
> > 
> > And looking at the "reload" board this definitly seems to be a very
> > different product with it being a system-on-module+baseboard design with
> > additional peripherals like that sata bridge, camera interfaces and
> > probably
> sata bridge is just a SATA to usb bridge and the "reload" bring back the
> DVP camera interface and
> a HDMI rx chip connected to the other MIPI camera interface.

there are always more things to control (reset pins, regulators) and the usb 
subsystem is currently in the process of getting support for such "embedded" 
uses.


> > more.
> > 
> > As you might've seen, most Rockchip boards are based on some reference-
> > design, so are similar in a big part of their core layout.
> 
> Yes, from the evb. But the even the main board of evb in rockchip
> company have at lease 3 versions
> as I known.
> Also the evb is found by power board, main board and core board.
> 
> > So, looking at the vastly different product the reload is, I'd really
> > like to have a separate dts for the reload, to not run into more
> > confusing differences later on.
> 
> The main problem is that power connections are different. That is why I
> decide to make a
> separate dts. If the kernel introduce the override dts, I could have a
> better way to implement
> it.

Just to make sure we're not talking about different things. This was meant 
to illustrate that even though core layouts often look similar we should not 
try to connect different product board files unnecessarily, as the small 
differences will make everything more complicated.

The "reload" definitly is a completely different product that only shares 
the manufacturer (firefly) and the soc (rk3288) with the other product and 
as I wrote should get its own independent dts file.


If anything you could do a split into a reload-core dtsi for the system-on-
module part and a baseboard dts that includes that (something like what is 
done for rk3288-rock2).



> > Also, when adding a new board, please also add an entry to
> > Documentation/devicetree/bindingd/arm/rockchip.txt
> 
> I would send a patch set in a few days.
> 
> > Thanks
> > Heiko
> 
> Thank you for you review and you patient again

no problem, always nice to have more people play with Rockchip stuff on a 
mainline kernel :-)


Heiko
