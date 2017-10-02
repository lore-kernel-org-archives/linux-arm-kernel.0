From: acme@redhat.com (Arnaldo Carvalho de Melo)
Date: Mon, 2 Oct 2017 13:49:30 -0300
Subject: [PATCH v5 6/7] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20171002141405.GC12847@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-7-git-send-email-will.deacon@arm.com>
 <20170929171940.2aa33d00463b1e9c987aea15@arm.com>
 <20171002141405.GC12847@arm.com>
Message-ID: <20171002164930.GB2121@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Oct 02, 2017 at 03:14:05PM +0100, Will Deacon escreveu:
> On Fri, Sep 29, 2017 at 05:19:40PM -0500, Kim Phillips wrote:
> > On Thu, 28 Sep 2017 15:09:50 +0100
> > Will Deacon <will.deacon@arm.com> wrote:
> > > +	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> > > +		return -EOPNOTSUPP;
> > > +	if (attr->exclude_idle)
> > > +		return -EOPNOTSUPP;

> > "PMU Hardware doesn't support sampling/overflow-interrupts." will be
> > printed if the user didn't specify a sample period.  Otherwise, a
> > string with "/bin/dmesg may provide additional information." will be
> > printed.

> > I was hoping for a response from acme by now for this:

> > https://www.spinics.net/lists/linux-perf-users/msg04066.html

> > Alas, nothing.  Looking at the #ifdef x86 in evsel.c, I'm guessing
> > it'll be ok, although I'm still not sure how PMU-specific we can get in
> > evsel.c, nor whether it's ok to communicate lists of h/w supported
> > sample periods through /sys/bus/event_source/devices/...
> > 
> > acme?  OK to refactor evsel messaging for Arm, including parsing for
> > which PMUs are being used, so customize the message?
> 
> Arnaldo's probably got enough on his plate maintaining perf tool, so my
> advice would be to post a patch as an RFC and use that as a concrete basis
> for discussion. It often works out better starting with code, even if none
> of it ends up getting merged (and you can include bits of your email above
> in the cover letter).

I'm all for more informative messages, and if you guys agree on how to
provide the info in a way that combined with logic in evsel.c, I'd say
do what Will suggested, post a patch series and include usage examples,
before and after.

- Arnaldo
