From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 11:52:15 +0000
Subject: [PATCH] arm64: enable ARCH_WANT_RELAX_ORDER for aarch64
In-Reply-To: <5bcff420-2ba7-7f64-9c52-41a5c60e9c31@huawei.com>
References: <35233df0-3406-e66f-d9d2-bf7ed7814386@huawei.com>
 <d97d0876-3e00-1979-72de-35fd81bfedf5@arm.com>
 <5bcff420-2ba7-7f64-9c52-41a5c60e9c31@huawei.com>
Message-ID: <20170320115214.GG17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 10:06:48PM +0800, Ding Tianhong wrote:
> On 2017/3/13 21:31, Robin Murphy wrote:
> > On 13/03/17 12:03, Ding Tianhong wrote:
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 8c7c244..36249a3 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -115,6 +115,7 @@ config ARM64
> >>  	select SPARSE_IRQ
> >>  	select SYSCTL_EXCEPTION_TRACE
> >>  	select THREAD_INFO_IN_TASK
> >> +	select ARCH_WANT_RELAX_ORDER
> > 
> > I'd say the first order of business is to rename this config option to
> > IXBGE_82599_WANT_RELAXED_ORDER so that it's not entirely misleading and
> 
> not only for 82599, including 82598, 82576....
> 
> > ambiguous. At first glance it looks far more like something scary to do
> > with memory barriers than a network driver option. Howcome this isn't
> > just in drivers/net/intel/Kconfig as a "default y if SPARC" bool anyway?
> 
> didn't see any essential differences, and I still need to get some Acked by arm maintainer.
> 
> > 
> 
> Yes, more memory barriers always affect the performance especially for
> some architecture not just like sparc, any optimization should be taken seriously
> especially for aarch64.

If this is a legitimate optimisation to apply (which nobody seems to be sure
about), then I'd *much* rather it was handled entirely in the driver and
predicated on CONFIG_ARM64. I can't select ARCH_WANT_RELAX_ORDER without
some notion of what on Earth that means, and whether or not other drivers
can also use that to infer some property about the arm64 ordering model.

Will
