From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Sep 2016 10:35:03 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474312560.4283.10.camel@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
 <1474260085.15220.17.camel@buserror.net>
 <20160919165258.GA30584@leverpostej>
 <1474304489.4283.6.camel@buserror.net>
 <20160919170707.GC30584@leverpostej>
 <1474312560.4283.10.camel@buserror.net>
Message-ID: <20160920093503.GA1045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 02:16:00PM -0500, Scott Wood wrote:
> On Mon, 2016-09-19 at 18:07 +0100, Mark Rutland wrote:
> > > > Reconsidering my suggestion, I realise this will also affect the MMIO
> > > > timers, so that doesn't work.
> > > > 
> > > > So for the moment, I guess we have to keep fsl_a008585_set_next_event().
> > > What is the problem with MMIO timers? ?needs_fsl_a008585_workaround()
> > > should
> > > always be false for them.
> > As suggested, needs_fsl_a008585_workaround() takes no parameter, and
> > set_next_event is called for both cp15/sysreg and MMIO timers. So it
> > would either be true for all, or false for all.
> > 
> > If it's true for all, we'd end up calling fsl_a008585_set_next_event()
> > for the MMIO timers too.
> 
> There should not be any MMIO timers on a system where
> fsl_a008585_set_next_event() returns true.

I'm generally not keen on relying on that.

For reference, are no MMIO timers implemented at all, or are they simply
not listed in the DT today?

Thanks,
Mark.
