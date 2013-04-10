From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 19:54:21 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <yw1xip3u8uni.fsf@unicorn.mansr.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
Message-ID: <20130410185421.GI14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 12:58:09PM +0100, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Wed, Apr 10, 2013 at 12:18:19PM +0100, M?ns Rullg?rd wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > The situation with VFP is likely less disruptive - only instructions
> >> > which aren't implemented in hardware (or, for example, if you ask for
> >> > inexact exceptions to be enabled) which are bounced to the software
> >> > support code will be affected.  I think OMAP should get away unscathed,
> >> > but ARM's implementation will bounce if inexact exceptions are enabled
> >> 
> >> What do you mean by this?  OMAP uses ARM's cores.
> >
> > OMAP's VFP reports that it never traps to support code for VFP instructions,
> > so the emulation code is never used on OMAP.
> 
> That is true for OMAP2 (ARM1136/VFP11) and OMAP3 (Cortex-A8).  OMAP4
> (Cortex-A9) and OMAP5 (Cortex-A15) both trap on vector operations.

No.  Both OMAP3 and OMAP4 report that they are VFP subarchitecture 3,
and the VFP subarchitecture 3 never traps to support code for any
instruction (it's the "null subarchitecture" value.)

These are the values reported by various platforms I have access to:

+ * Dove:  VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 5
+ * OMAP4: VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 1
+ * OMAP3: VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
+ * Pi:    VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 5

and "architecture" is actually the VFP subarchitecture number.
