From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 28 Jun 2017 20:16:38 -0500
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170628113249.GF5981@leverpostej>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
 <20170628112601.GD5981@leverpostej>
 <20170628113249.GF5981@leverpostej>
Message-ID: <20170628201638.01204c14719514217433e82d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jun 2017 12:32:50 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Jun 28, 2017 at 12:26:02PM +0100, Mark Rutland wrote:
> > On Tue, Jun 27, 2017 at 04:07:58PM -0500, Kim Phillips wrote:
> > > FWIW, there is also this one I saw with mmap-pages set to 5
> > > (pages), which gets rounded up to 8 pages:
> > 
> > Sorry, *what* does the rounding upwards? Userspace, perf core, or the
> > driver? Where?

SPE implementations may vary from the minimum buffer alignment of the
smallest available page size, so I left the bts userspace tool code's
upwards-rounding code intact for now.  

I'll take this opportunity to submit the SPE perf tool patch in the
form of a reply to this email:  Look for the rounding code in
tools/perf/arch/arm64/util/arm-spe.c:arm_spe_recording_options().

> > That's worrying. I'll see if I can reproduce this.
> 
> Actually, this might be down to the IDX2OFF() macro being borked for non
> power-of-two buffer sizes.
> 
> Do you have Will's latest fixes? In his tree there's a commit:
> 
>   4f331cd62531dce2 ("squash! drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> 
> ... which should fix the IDX2OFF() bug.

yes, I've been running with that squash! commit since a couple of days
after I noticed it over a week ago.

> It's be good to reproduce the issue if we can, regardless.

FWIW, I couldn't the little I tried today.

Kim
