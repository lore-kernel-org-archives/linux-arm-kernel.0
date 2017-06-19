From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 19 Jun 2017 14:26:33 -0500
Subject: [PATCH] [perf/core branch] perf coresight: Fix ARM builds
 caused by misplaced __printf
In-Reply-To: <20170619184209.GB13640@kernel.org>
References: <20170616145907.baba73eda242efe194e072d0@arm.com>
 <CANLsYkyG3E9xiOyJz_5EA0B0oQGsSCy2oW7i1iY5YUxU1imKng@mail.gmail.com>
 <20170619184209.GB13640@kernel.org>
Message-ID: <20170619142633.51d138db0c0b8befa0542bf6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jun 2017 15:42:09 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Jun 19, 2017 at 11:51:20AM -0600, Mathieu Poirier escreveu:
> > On 16 June 2017 at 13:59, Kim Phillips <kim.phillips@arm.com> wrote:
> > > -static int cs_device__print_file(const char *name, const char *fmt, ...) __printf(2, 3)
> > > +static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
> > >  {
> > >         va_list args;
> > >         FILE *file;
> > 
> > I just tested Kim's solution on my side.
> > 
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Thanks for checking, since I haven't pushed this to Ingo I just squashed
> Kim's fix into the buggy cset.
> 
> Now I'm trying to build it with lots of cross build containers to see if
> there are any other problems before push this up to Ingo.

Thanks, I'm still trying to learn the submission process...

Slightly off-topic, but when you push kernel.org/.../acme/linux.git, do
you push --tags?

If I do a fresh clone, checkout perf/core or urgent, build perf,
PERF-VERSION-GEN first uses git to find the version number, then the
Makefile.  But in acme/linux.git, the latest version tag looks to match
the master branch version: 3.2: so I get a 3.2-reporting version on
what should be 4.12-rc4 (perf/core's current Makefile):

$ tools/perf/perf --version
perf version 3.2.gd15e591

Is this an acme/linux.git tree maintenance issue, or should
PERF-VERSION-GEN be modified to compare versions gotten from git vs.
the Makefile, and just use the higher one?

Thanks,

Kim
