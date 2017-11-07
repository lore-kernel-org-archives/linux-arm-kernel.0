From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Nov 2017 02:17:25 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <20171106184753.xyj7xmlrzbfgovqz@sirena.co.uk>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106184753.xyj7xmlrzbfgovqz@sirena.co.uk>
Message-ID: <20171107021724.GB23638@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, [+akpm, +Kirill]

On Mon, Nov 06, 2017 at 06:47:53PM +0000, Mark Brown wrote:
> On Mon, Nov 06, 2017 at 04:30:41AM -0800, kernelci.org bot wrote:
> 
> > next/master boot: 273 boots: 63 failed, 209 passed with 1 untried/unknown (next-20171106)
> 
> > Full Boot Summary: https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20171106/
> > Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20171106/
> 
> There's several arm64 boots failing in -next at the minute, including
> qemu - the last success seems to have been 20171017 which isn't terribly
> helpful, obviously -next was spotty in October:
> 
>    https://kernelci.org/boot/id/5a001ef359b5149e6f1cdd22/
> 
> There's also this physical failure:
> 
>    https://kernelci.org/boot/id/5a001efa59b5149e7d1cdd20/
> 
> Some others could be noise from the labs, some of them have been noisy
> for a while, but mainline seems to be fine.  The majority of them seem
> to be failing with no console output which isn't ideal.
> 
> Is this known?

There is a known boot failure due to 83e3c48729d9:

http://lkml.kernel.org/r/20171102141210.gu4cwpoq2e6o7liu at black.fi.intel.com

There's a patch there which appears to fix the problem, but it's not yet
in next (and it needs to go via -mm).

Will
