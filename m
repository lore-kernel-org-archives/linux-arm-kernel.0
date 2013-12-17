From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Dec 2013 14:22:48 +0100
Subject: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131217130435.GV4360@n2100.arm.linux.org.uk>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <5295539.cCkPY1PpyC@flatron>
 <20131217124505.GB17210@ulmo.nvidia.com>
 <1500339.E8bGm7xZUi@flatron>
 <20131217130435.GV4360@n2100.arm.linux.org.uk>
Message-ID: <20131217132247.GB2329@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:04:35PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 17, 2013 at 01:54:35PM +0100, Tomasz Figa wrote:
> > On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
> > > I fail to see how that would eliminate the problem with the types. That
> > > said I don't actually see sparse complaining about any type mismatches.
> > > That's probably because the various macros implicitly cast to u32.
> > 
> > Well, in BE variant you would read the register using __raw_readl() into
> > a __be32 and then get an u32 from be32_to_cpu() and return it. Similarly
> > for writes
> 
> __raw_readl() returns a u32, so you'll get a warning trying to assign a
> u32 to a __be32.

If sparse doesn't complain about the original code here, does that mean
we have a bug that should be fixed?

> We do have ioread32() and ioread32be() which do the appropriate conversion,
> as well as the write versions too.  They both include the barrier if you're
> overly concerned about that.

A few years ago GregKH commented in response to a patch that ioread*()
weren't supposed to be used for memory-mapped only devices. The original
purpose apparently was to allow drivers to work with both I/O and
memory-mapped devices.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/f4f9097f/attachment.sig>
