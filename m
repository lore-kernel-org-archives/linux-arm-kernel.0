From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Apr 2013 12:18:19 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410104002.GF14496@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 10 Apr 2013 11:40:02 +0100")
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
Message-ID: <yw1xmwt68whw.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> The situation with VFP is likely less disruptive - only instructions
> which aren't implemented in hardware (or, for example, if you ask for
> inexact exceptions to be enabled) which are bounced to the software
> support code will be affected.  I think OMAP should get away unscathed,
> but ARM's implementation will bounce if inexact exceptions are enabled

What do you mean by this?  OMAP uses ARM's cores.

> or in a few corner cases.  Qualcomm is likely to be the worst affected
> by this.
>
> Will Deacon has tested debian armhf on a Cortex-A15 with VFP emulation
> support removed, which boots successfully.

Cortex-A9 and later lack hardware support for VFP vector operations.
Any code using these will fail to run without the software emulation.
Of course such code is already horribly slow on these cores and should
be fixed, so perhaps this is not such a terrible thing.

-- 
M?ns Rullg?rd
mans at mansr.com
