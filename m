From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Dec 2016 11:08:23 +0000
Subject: [PATCH v11 7/7] arm: pmu: Add PMU definitions for cores not
 initially online
In-Reply-To: <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
 <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
 <20161206152118.GK2498@arm.com>
 <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
Message-ID: <20161207110823.GA7054@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 11:56:56AM -0600, Jeremy Linton wrote:
> Hi,

> Which might not be the right choice because
> even without these ACPI specific bits, simply running a few cpus
> online/offline while simultaneously doing something like `perf stat
> -e cache-misses ls &` in a loop causes deadlocks/crashes.
> 
> That problem doesn't appear to be specific to the ACPI/PMU so I've
> stayed away from it in this patch set, although potentially a larger
> fix might cover this as well.

Urrgh; I can reproduce lockups on Seattle with v4.9-rc8.

I'll look into that.

If you see any more issues in this area, please report them in a new
thread.

Thanks,
Mark.
