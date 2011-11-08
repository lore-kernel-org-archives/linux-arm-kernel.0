From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 18:29:55 +0000
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
 <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
Message-ID: <20111108182955.GH12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 05:23:46PM +0200, Felipe Balbi wrote:
> On Tue, Nov 08, 2011 at 04:15:10PM +0100, Nicolas Ferre wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On 11/08/2011 03:41 PM, Felipe Balbi :
> > 
> > >> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */
> > > 
> > > I don't think you should be using cpu_is_* on drivers.
> > 
> > It is a common pattern in at91 drivers and has worked for ages.
> > Do you think it is related to the need to be able to compile the
> > driver for any SoC in the case of multi-SoC zImage support?
> 
> we have drivers compiling on multiple OMAP versions without those hacks.
> Generally, we check the IP revision for that. Don't you have a Revision
> register of some sort ?

I'm not sure what your objection is - this is no different from what
happens with OMAP when detecting OMAP1,2,3,4 etc.  E.g.:

drivers/mfd/twl-core.c:     if (cpu_is_omap2430())
drivers/media/video/omap3isp/isp.c: if (cpu_is_omap3630())
drivers/media/video/omap/omap_vout.c:               if (cpu_is_omap24xx() || cpu_is_omap34xx())
drivers/media/video/omap/omap_voutlib.c:    if (cpu_is_omap24xx()) {
drivers/media/video/omap/omap_voutlib.c:    } else if (cpu_is_omap34xx()) {
drivers/media/video/omap/omap_voutlib.c:    if (cpu_is_omap24xx()) {

for a small selection.
