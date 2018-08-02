From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Aug 2018 11:57:05 +0100
Subject: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
In-Reply-To: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
References: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180802105705.GB14312@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 09:45:26AM +1200, Chris Packham wrote:
> GCC warns
> 
>   arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This is because we rely on the for_each_cpu loop in armpmu_request_irqs
> to initialise err. The warning is a little bogus because we know if
> there were 0 CPUs this code would not be running.
> 
> Initialise err to 0 to avoid the warning.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm not
> sure if it was dismmissed as "meh, gcc is wrong" or if it was just wainting for
> someone with some round tuits.

Which version of GCC are you using? I don't see this warning locally.

Will
