From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 22 Mar 2016 17:49:47 +0100
Subject: [PATCH 3/5] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <CANK38rZQSOJPN76eP1LFcx8GduZRf8z-3w_kriAUg2=uON8Rcw@mail.gmail.com>
References: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
 <1458133309-17045-4-git-send-email-ashoks@broadcom.com>
 <20160322100110.GC31126@arm.com>
 <CANK38rZQSOJPN76eP1LFcx8GduZRf8z-3w_kriAUg2=uON8Rcw@mail.gmail.com>
Message-ID: <20160322164947.GB23772@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashok,

On Tue, Mar 22, 2016 at 10:09:42PM +0530, Ashok Sekar wrote:
> Hi Will,
> 
> On Tue, Mar 22, 2016 at 3:31 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Ashok,
> >
> > On Wed, Mar 16, 2016 at 06:01:47AM -0700, Ashok Kumar wrote:

[...]

> >> +static struct attribute *vulcan_pmuv3_event_attrs[] = {
> >> +     &armv8_event_attr_sw_incr.attr.attr,
> >> +     &armv8_event_attr_l1i_cache_refill.attr.attr,
> >> +     &armv8_event_attr_l1i_tlb_refill.attr.attr,
> >> +     &armv8_event_attr_l1d_cache_refill.attr.attr,
> >> +     &armv8_event_attr_l1d_cache_access.attr.attr,
> >> +     &armv8_event_attr_l1d_tlb_refill.attr.attr,
> >> +     &armv8_event_attr_ld_retired.attr.attr,
> >> +     &armv8_event_attr_st_retired.attr.attr,
> >> +     &armv8_event_attr_inst_retired.attr.attr,
> >> +     &armv8_event_attr_exc_taken.attr.attr,
> >> +     &armv8_event_attr_exc_return.attr.attr,
> >
> > ... but I'm not keen on having these tables in the kernel for each CPU
> > PMU we support. Where I'd like to get to is:
> >
> >   * We expose the architected events (0x0-0x3f) in /sys using the existing
> >     PMUv3 tables in conjunction with PMCEIDn_EL0 (Jan mentioned this before)
> I will use armv8_pmuv3_event_attrs itself for the time being for Vulcan.
> Once the events identification mechanism is done using PMCEIDn_EL0, it
> should take care
> of removing the unsupported events from the table for Vulcan too.
> Jan is working on this currently? or else I could look into it.

I did not find time yet to work on PMCEID support, so feel to start on
it but please keep me in the loop.

Jan
