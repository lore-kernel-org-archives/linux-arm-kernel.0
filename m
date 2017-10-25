From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 20:11:08 -0500
Subject: [RFC 1/3] perf tool: Introduce arch-specific supplemental perf
 open strerror capability
In-Reply-To: <20171024133535.GC13445@arm.com>
References: <20171024030404.ec366ec2d9c38910ccd84ba5@arm.com>
 <20171024133535.GC13445@arm.com>
Message-ID: <20171024201108.0fcc0118cf0c7ccd835c63d6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Oct 2017 14:35:35 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Oct 24, 2017 at 03:04:04AM -0500, Kim Phillips wrote:
> > Introduce new tools/perf/arch/*/util/evsel.c:perf_evsel__suppl_strerror()
> > so each arch can start to customize usability for its h/w PMU drivers.
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> > ---
> >  tools/perf/arch/x86/util/Build   |  1 +
> >  tools/perf/arch/x86/util/evsel.c | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.c          | 21 +++++++++++++++------
> >  tools/perf/util/evsel.h          |  2 ++
> >  4 files changed, 42 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/perf/arch/x86/util/evsel.c
> 
> This looks sensible to me, although it's difficult to justify all of the
> parameters to perf_evsel__suppl_strerror judging by this patch alone.

I looked at possibly reducing the number of parameters, but since both
evsel and target elements are used to evaluate the condition the error
occurred in, and err, msg, and size are required for basic strerror
functioning, they all look to stay: see the shared strerror function to
see how they're all used.

Thanks,

Kim
