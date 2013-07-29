From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 29 Jul 2013 11:51:30 -0300
Subject: [PATCH 3/5] ARM: dove: add MBus DT node
In-Reply-To: <51F67AD8.1070904@gmail.com>
References: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375101114-28858-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <51F661DE.1070106@gmail.com> <20130729135227.GA2417@localhost>
 <51F67AD8.1070904@gmail.com>
Message-ID: <20130729145129.GD2417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 04:23:20PM +0200, Sebastian Hesselbarth wrote:
> On 07/29/2013 03:52 PM, Ezequiel Garcia wrote:
> > Hi Sebastian,
> >
> > (Ccing devicetree ML)
> >
> > On Mon, Jul 29, 2013 at 02:36:46PM +0200, Sebastian Hesselbarth wrote:
> >> On 07/29/2013 02:31 PM, Sebastian Hesselbarth wrote:
> >>> This adds a MBus node including ranges and pcie apertures required later.
> >>>
> >>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>> ---
> >>>    arch/arm/boot/dts/dove.dtsi |   19 +++++++++++++++++++
> >>>    1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> >>> index 397674c..bdda016 100644
> >>> --- a/arch/arm/boot/dts/dove.dtsi
> >>> +++ b/arch/arm/boot/dts/dove.dtsi
> >>> @@ -29,6 +29,20 @@
> >>>    		marvell,tauros2-cache-features = <0>;
> >>>    	};
> >>>
> >>> +	mbus {
> >>> +		compatible = "marvell,dove-mbus", "marvell,mbus", "simple-bus";
> >>> +		#address-cells = <2>;
> >>> +		#size-cells = <1>;
> >>> +		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256M MEM space */
> >>> +		pcie-io-aperture  = <0xf2000000 0x00200000>; /*   2M I/O space */
> >>
> >> Actually, current v9 of the mbus patch set still requires "controller"
> >> property to match the corresponding controller node. I had a short
> >> discussion with Ezequiel to possibly just use of_find_compatible_node
> >> and blindly assumed post-v8 will already use it.
> >
> > Ah, regarding this: despite your good arguin against the 'controller' property approach,
> > I still feel a bit inclined for it, as I like the way it tightly-binds the two nodes.
> 
> I understand that the phandle property *shows* you that both are
> related. But with DT you should always ask for every property, if
> (a) it is really required to do the job and (b) does it really
> describe the HW or just your SW needs/wishes.
> 

I see and I understand your point. For some reason it still feels
a bit dirty to set this kind of compatible nodes requirement (one
node simply requiring another node).

I would hate to set a precedent for a dirty solution...

Maybe the DT maintainers can shed some light on this?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
