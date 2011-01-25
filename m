From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 17:16:19 +0530
Subject: questions about arm trustzone
In-Reply-To: <20110125102652.GB11507@n2100.arm.linux.org.uk>
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com><8yad3nlh18e.fsf@huya.qualcomm.com><AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
	<20110125102652.GB11507@n2100.arm.linux.org.uk>
Message-ID: <bb0c3855a121603232d022b4062752a6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King -
> ARM Linux
> Sent: Tuesday, January 25, 2011 3:57 PM
> To: sen wang
> Cc: David Brown; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: questions about arm trustzone
>
> On Tue, Jan 25, 2011 at 05:19:16PM +0800, sen wang wrote:
> > It seems linux run in the normal world, and the "scm.c" ?is the
> path
> > to the monitor mode.
> > where can I find the example code for monitor and secure world?
>
> OMAP also uses smc: arch/arm/mach-omap2/omap44xx-smc.S
>
> There's no interface defined for smc because it's highly vendor and
> implementation specific.  It's just like a SWI (or svc) where it
> causes entry via a vector into a priviledged mode, which can be
> thought of being similar to a branch to a vector with a mode switch.
>
The code above won't give major details of how the monitor mode is
implemented.  But as Russell said, it's pretty much vendor specific.

On OMAP, We have standard API interfaces to enter into monitor
world. One of the parameter denotes the kind of service, is
requested.

Regards,
Santosh
