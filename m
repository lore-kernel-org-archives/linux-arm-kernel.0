From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 16:23:13 +0000
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <5481D9BF.2090007@ti.com>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
Message-ID: <20141205162312.GB11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 10:13:51AM -0600, Nishanth Menon wrote:
> On 12/05/2014 10:10 AM, Nishanth Menon wrote:
> > Case #2: Reverting the following allows boot.
> > 
> > From next-20141204
> > 10df7d5 ARM: 8211/1: l2c: Add support for overriding prefetch settings
> > revert this  -> boot still fails
> > 
> > d42ced0 ARM: 8210/1: l2c: Get outer cache .write_sec callback from
> > mach_desc only if not NULL
> > revert this  -> boot still fails
> > 
> > 46b9af8 ARM: 8209/1: l2c: Add interface to ask hypervisor to configure L2C
> > revert this  -> boot still fails
> > 
> > c94e325 ARM: 8208/1: l2c: Refactor the driver to use commit-like
> > revert this  -> boot passed (first bad commit).
> > 
> > 
> 
> + linux-samsung soc and updated Thomaz's mail ID (gmail now).

Given where we are in the cycle (-final likely this weekend) the only
thing we can do right now is to drop the patch set; exynos (and mvebu)
will have to wait another cycle until this patch set (hopefully in a
revised form) can be merged.

I think we need 8208/1 split up into smaller changes so that the cause
of this regression can be found.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
