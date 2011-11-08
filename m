From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 21:02:02 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111108185525.GI12913@n2100.arm.linux.org.uk>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
 <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
 <20111108182955.GH12913@n2100.arm.linux.org.uk>
 <20111108184447.GB24399@legolas.emea.dhcp.ti.com>
 <20111108185525.GI12913@n2100.arm.linux.org.uk>
Message-ID: <20111108190200.GC24399@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 06:55:25PM +0000, Russell King - ARM Linux wrote:
> > so ? Instead of saying this to me, you should contact the
> > authors/maintainers of those drivers and ask them to clean that up.
> 
> Oh for god sake, I was just asking you to clarify your statement in
> light of what is currently being done.
> 
> Now, let me set something straight.  I've been saying that machine_is_xxx()
> should not be used in drivers.  That's a platform thing and platform
> specifics should not be in drivers - it should be passed in via DT or
> platform data.  That's enforced by the way DT works (Grant's decision
> not mine) - with DT you don't have any kind of testable machine ID for
> machine_is_xxx() to use.
> 
> I've never said that cpu_is_xxx() should not - that's something *other*
> people are saying (and quite rightly so) because if we're going to start
> sharing drivers between different SoCs (or even architectures - eg, PXA
> IP appearing on x86) then it doesn't make sense for the type of SoC to
> be tested.  It makes more sense for the revision of the IP implementation
> to be checked IFF such information is available.  If not, some other way
> of controlling the 'features' needs to be sought.
> 
> As far as the use of asm/*.h includes, I've NEVER made any statement
> about the use of those in drivers.  In fact, I don't see any reason to
> avoid them _provided_ they're standard cross-arch includes.
> 
> As for mach/*.h includes, I don't think that I've made any statement
> about those either, but at this point - given that we're working towards
> a single zImage on ARM - it is _sensible_ to avoid such includes in
> drivers.
> 
> So, I think your reaction to my statement is way off mark, and you're
> attributing statements (that it seems you personally don't agree with)
> to me.

If I did, then it's really my fault. But I _do_ remember you complaining
about uses of <asm/gpio.h> instead of <linux/gpio.h>, for example.

Now, all the other topics I agree and, in fact, have been pushing for
that as I can. Specially with regards to IP cores being shared among
several architectures (see drivers/usb/dwc3 where I have a core driver
shared between ARM and PCI/x86).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/dec12d42/attachment.sig>
