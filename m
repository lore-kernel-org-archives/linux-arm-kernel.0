From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 17:38:18 +0000
Subject: [PATCH 0/5] arm_pmu: fix lockdep issues with ACPI systems
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171211173817.GE3275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:12:34PM +0000, Mark Rutland wrote:
> Currently the arm_pmu ACPI code is somewhat dubious. It attempts ot
> allocate memory any manpiulate IRQs in a hotplug callback, which is an
> atomic context.
> 
> These patches (based on the arm64 for-next/core branch [1]) attempt to
> address this by moving work out of hotplug callback, requiring a
> reorganisation of the common arm_pmu code.
> 
> I've given these a boot-test on a Juno R1 system, both with DT and ACPI.
> In either case the PMU works as expected, and lockdep seems happy.
> 
> I've pushed the series out to my arm64/acpi-pmu-lockdep branch [2].

This mostly looks ok to me; I've left some minor comments on individual
patches. My main concern is taking this as a fix, because there's an awful
lot here.

Is there anything simpler we can do for 4.15/stable?

Will
