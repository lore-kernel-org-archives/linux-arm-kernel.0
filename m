From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 22:28:33 +0530
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <20110208164747.GD6188@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
Message-ID: <78d0134576ace6be5874871076cf0c10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, February 08, 2011 10:18 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>
> On Tue, Feb 08, 2011 at 10:06:20PM +0530, Santosh Shilimkar wrote:
> > Have tested this series on OMAP4430 and OMAP3430.
> > Don't know if it helps to push some of these patches to be part
> > of rc cycles. At least the SMP specific fixes should get merged
> > otherwise, builds like omap2plus_defconfig won't be running
> > right configuration on SMP machine.
>
> It's _too_ _late_ in the rc cycle for a fix of this size.  As I've
> said
> (several times) it was only possible for rc1.  That boat has been
> missed
> as we're now on rc4.  We could see 2.6.38 in as little as two weeks
> time.
>
>  27 files changed, 183 insertions(+), 197 deletions(-)
>
> is too big.
>
Ok. Sorry about delay in testing out these patches.

> There's still the outstanding question over:
>
>   ARM: v6k: use CPU domain feature if we include support for arch <
> ARMv6K
>
> which remains unsettled.
>
> I think it's probably going to be better to _purposely_ break the
> OMAP
> build when it covers v6 and v7 CPUs in these kernels as I don't
> think it's
> sanely fixable given where we are.  Again, that's something I _did_
> point out at the time.
>
Any alternative possible other than breaking the omap2plus build?
It's quite useful to have one build which covers majority of the
omap machines.

Regards,
Santosh
