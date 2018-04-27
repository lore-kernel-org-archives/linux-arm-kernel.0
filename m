From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Apr 2018 10:30:27 +0100
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
Message-ID: <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On Thu, Apr 26, 2018 at 05:06:24PM -0500, Kim Phillips wrote:
> On Wed, 25 Apr 2018 14:30:47 +0530
> Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:
> 
> > +static int thunderx2_uncore_event_init(struct perf_event *event)

> This PMU driver can be made more user-friendly by not just silently
> returning an error code such as -EINVAL, but by emitting a useful
> message describing the specific error via dmesg.

As has previously been discussed on several occasions, patches which log
to dmesg in a pmu::event_init() path at any level above pr_debug() are
not acceptable -- dmesg is not intended as a mechanism to inform users
of driver-specific constraints.

I would appreciate if in future you could qualify your suggestion with
the requirement that pr_debug() is used.

Thanks,
Mark.
