From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 14:55:18 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123143322.GD7382@totoro>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
Message-ID: <20111123145517.GE20272@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 02:33:22PM +0000, Jamie Iles wrote:
> On Wed, Nov 23, 2011 at 01:50:34PM +0000, Mark Brown wrote:

> > It looks like there's a second bug breaking the boot in there - testing
> > your commit the board boots but if I test the tip of Russell's for-next
> > then that breaks again.  I'm just starting another bisect and
> > considering sending a patch to add a git finger-point alias.

> Thanks for your patience Mark!  Please let me know if there's anything I 
> can do to help.

My bisect turned up a second candidate - Nicholas' commit 549158d (ARM:
move iotable mappings within the vmalloc region).  I reverted that and
subsequent commits depending on it and my system now appears to boot
fine with -next (with OF turned on to get the ops for the VIC).  This
code is all a bit deep for me so I've no real idea what might be wrong.
