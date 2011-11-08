From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 21:58:55 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111108193930.GJ12913@n2100.arm.linux.org.uk>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
 <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
 <20111108182955.GH12913@n2100.arm.linux.org.uk>
 <20111108184447.GB24399@legolas.emea.dhcp.ti.com>
 <20111108185525.GI12913@n2100.arm.linux.org.uk>
 <20111108190200.GC24399@legolas.emea.dhcp.ti.com>
 <20111108193930.GJ12913@n2100.arm.linux.org.uk>
Message-ID: <20111108195854.GD24399@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 07:39:30PM +0000, Russell King - ARM Linux wrote:
> But, that's something very different from your statement in your previous
> message about my alleged stance on *all* asm/*.h includes in drivers,
> which is FALSE.

http://marc.info/?l=linux-arm-kernel&m=132077795410718&w=2

I don't see me complaining about *all* headers anywhere in that message.
I did generalize, but I didn't stated you were complaining about *all*
headers. Go back and read it for yourself.

> > Now, all the other topics I agree and, in fact, have been pushing for
> > that as I can. Specially with regards to IP cores being shared among
> > several architectures (see drivers/usb/dwc3 where I have a core driver
> > shared between ARM and PCI/x86).
> 
> Good, so you've just taken back most of what you said in your previous
> message.

of course not... maybe you misunderstood me. My whole point was to avoid
using cpu_is_* exactly because it would prevent this driver from
compiling anywhere outside of ARM builds.

here's where you chiped in:

http://marc.info/?l=linux-kernel&m=132077706910296&w=2

And a small quote:

| On Tue, Nov 08, 2011 at 05:23:46PM +0200, Felipe Balbi wrote:
| > On Tue, Nov 08, 2011 at 04:15:10PM +0100, Nicolas Ferre wrote:
| > > -----BEGIN PGP SIGNED MESSAGE-----
| > > Hash: SHA1
| > > 
| > > On 11/08/2011 03:41 PM, Felipe Balbi :
| > > 
| > > >> +	if (cpu_is_at91rm9200()) {			/*  AT91RM9200 Errata #22 */
| > > > 
| > > > I don't think you should be using cpu_is_* on drivers.
| > > 
| > > It is a common pattern in at91 drivers and has worked for ages.
| > > Do you think it is related to the need to be able to compile the
| > > driver for any SoC in the case of multi-SoC zImage support?
| > 
| > we have drivers compiling on multiple OMAP versions without those
| > hacks.
| > Generally, we check the IP revision for that. Don't you have a
| > Revision register of some sort ?

You see ? I was asking $author to try and use some revision register in
order to apply erratas instead of using cpu_is_at91rm9200().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/b4dc04e0/attachment.sig>
