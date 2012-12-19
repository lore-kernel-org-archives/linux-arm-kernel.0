From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Dec 2012 11:27:28 +0000
Subject: [PATCH v2 4/6] ARM: psci: add support for PSCI invocations from
 the kernel
In-Reply-To: <alpine.LFD.2.02.1212181657020.1263@xanadu.home>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1212171537230.1263@xanadu.home>
 <20121218101125.GC9072@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1212181657020.1263@xanadu.home>
Message-ID: <20121219112728.GB26329@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 09:59:45PM +0000, Nicolas Pitre wrote:
> On Tue, 18 Dec 2012, Will Deacon wrote:
> > On Mon, Dec 17, 2012 at 08:51:27PM +0000, Nicolas Pitre wrote:
> > > On Mon, 17 Dec 2012, Will Deacon wrote:
> > > > +static int psci_cpu_suspend(struct psci_power_state state,
> > > > +			    unsigned long entry_point)
> > > > +{
> > > > +	int err;
> > > > +	u32 fn, power_state;
> > > > +
> > > > +	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
> > > > +	power_state = psci_power_state_pack(state);
> > > > +	err = invoke_psci_fn(fn, power_state, (u32)entry_point, 0);
> > > 
> > > Why do you need the u32 cast here?
> > 
> > That's a hangover from when entry_point was a void *. I'll fix that, thanks.
> 
> Hopefully you didn't pass virtual pointers to the PSCI call, did you?  :-)

...and I'd have gotten away with it if it wasn't for those meddling kids!

It was also made worse by Marc's code working first time too (after I blamed
the firmware like any sane kernel hacker would do :)

Will
