From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Apr 2018 15:37:20 +0100
Subject: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <20180427081525.f9dcc756678baf3bb6e6e473@arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
 <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
 <20180427093027.ngtuoezyh6mtz26p@lakrids.cambridge.arm.com>
 <20180427081525.f9dcc756678baf3bb6e6e473@arm.com>
Message-ID: <20180427143719.GA5093@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 08:15:25AM -0500, Kim Phillips wrote:
> On Fri, 27 Apr 2018 10:30:27 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Apr 26, 2018 at 05:06:24PM -0500, Kim Phillips wrote:
> > > On Wed, 25 Apr 2018 14:30:47 +0530
> > > Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:
> > > 
> > > > +static int thunderx2_uncore_event_init(struct perf_event *event)
> > 
> > > This PMU driver can be made more user-friendly by not just silently
> > > returning an error code such as -EINVAL, but by emitting a useful
> > > message describing the specific error via dmesg.
> > 
> > As has previously been discussed on several occasions, patches which log
> > to dmesg in a pmu::event_init() path at any level above pr_debug() are
> > not acceptable -- dmesg is not intended as a mechanism to inform users
> > of driver-specific constraints.
> 
> I disagree - drivers do it all the time, using dev_err(), dev_warn(), etc.
> 
> > I would appreciate if in future you could qualify your suggestion with
> > the requirement that pr_debug() is used.
> 
> It shouldn't - the driver isn't being debugged, it's in regular use.

For anything under drivers/perf/, I'd prefer not to have these prints
and instead see efforts to improve error reporting via the perf system
call interface.

Anyway, I think this driver has bigger problems that need addressing.

Will
