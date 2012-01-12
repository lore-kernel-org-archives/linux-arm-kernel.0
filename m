From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 12 Jan 2012 21:58:01 +0000
Subject: [PATCH] versatile: don't generate a duplicate IRQ domain
In-Reply-To: <20120112203756.GM1068@n2100.arm.linux.org.uk>
References: <1325867997-20761-1-git-send-email-jamie@jamieiles.com>
 <20120112203756.GM1068@n2100.arm.linux.org.uk>
Message-ID: <20120112215801.GB13991@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jan 12, 2012 at 08:37:56PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2012 at 04:39:57PM +0000, Jamie Iles wrote:
> > Now that the VIC driver handles the irqdomain natively we don't need to
> > generate one in the versatile core code.  Longer term we should move the
> > initialisation of both IRQ controllers to using of_irq_init() but
> > that'll need a little more work.
> > 
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Please confirm that this patch can be applied ontop of commit
> 356b95424cfb456e14a59eaa579422ce014c424b
> (Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k)

OK, this does apply, but it doesn't fail in the way I had expected.  
Actually, it doesn't barf at all because the generated domain that my 
patch removes has 0 IRQ's so it never gets attached to the irq_desc's.

However, this patch is still valid as we end up with two domains 
associated with the VIC but we get lucky as the real domain is 
registered first.  I can update the patch description to reflect this if 
you still want to apply it.

Incidentally, I've managed to get the versatile kernel booting under 
qemu (using an experimental build with DT support, up to trying to mount 
a rootfs), which seems to work nicely.  I just need to find a suitable 
rootfs and that'll be a nice test system.

Jamie
