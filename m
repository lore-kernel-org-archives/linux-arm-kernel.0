From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 8 Sep 2017 19:07:36 -0500
Subject: Prevent Kernel from resetting cycle counter
In-Reply-To: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
References: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
Message-ID: <20170908190736.de99a221c13be31c10103643@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Sep 2017 17:36:36 -0700
Jason Teplitz <jason@tensyr.com> wrote:

[adding linux-arm-kernel]

> I'm reading the armv8 PMU cycle counter from userspace and noticing
> that it gets periodically reset by something. Does anything inside the
> kernel reset these counters? I am not using perf, so I'm not sure why
> anything else would be touching them.

PMCCNTR only shows up in kernel perf/PMU and KVM code, so yes, no
reason for it to be reset, esp. if no arm-pmu interrupts are triggered.

Is the period constant, as if to suggest a wraparound?  Can you use
CNTVCT instead?

Thanks,

Kim
