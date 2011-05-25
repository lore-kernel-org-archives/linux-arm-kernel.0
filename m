From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 May 2011 13:50:47 +0100
Subject: [PATCH 0/5] ARMv6 and ARMv7 mm fixes
In-Reply-To: <4DDC2A59.8030109@codeaurora.org>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
	<4DDC2A59.8030109@codeaurora.org>
Message-ID: <002f01cc1ada$5e7ffaa0$1b7fefe0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> On 05/20/2011 04:19 AM, Will Deacon wrote:
> > Hello,
> >
> > There are a few issues with ASID handling and cache flushing on v6/v7
> > CPUs that have been identified when running Linux on the Cortex-A15.
> >
> > These patches solve the problems for the classic page tables. Additional
> > LPAE changes will be posted separately.
> >
> > Tested on a Realview-PBX platform with a dual-core Cortex-A9.
> 
> Should these patches be sent to the stable tree? Or do the problems only
> manifest on Cortex-A15?

I was planning to CC stable for patches 1 ("ARM: cache: ensure MVA is cacheline
aligned in flush_kern_dcache_area") and 4 ("ARM: mm: fix racy ASID rollover
broadcast on SMP platforms") as these affect existing v6 and v7 cores. The
remainder of the patches, although nice to have, only kick in on A15 as far as
I'm aware (due to aggressive caching of speculative level 1 entries).

I was hoping for some acks/tested-bys before then since these changes affect a
lot of platforms and the code is fairly scary.

Will
