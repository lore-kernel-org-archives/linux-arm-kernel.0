From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 30 Jan 2014 18:45:46 +0100
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <52E939CB.1020705@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
 <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
 <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
 <52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
 <52E939CB.1020705@amd.com>
Message-ID: <20140130174546.GF13543@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 12:26:35PM -0500, Suravee Suthikulanit wrote:
> On 1/29/2014 11:16 AM, Andreas Herrmann wrote:
> > On Wed, Jan 29, 2014 at 11:59:12AM -0500, Suravee Suthikulanit wrote:
> >> On 1/29/2014 10:57 AM, Rob Herring wrote:
> >>>>> diff --git a/include/linux/of.h b/include/linux/of.h
> >>>>>>> index 276c546..24e1b28 100644
> >>>>>>> --- a/include/linux/of.h
> >>>>>>> +++ b/include/linux/of.h
> >>>>>>> @@ -67,7 +67,7 @@ struct device_node {
> >>>>>>>    #endif
> >>>>>>>    };
> >>>>>>>
> >>>>>>> -#define MAX_PHANDLE_ARGS 8
> >>>>>>> +#define MAX_PHANDLE_ARGS 16
> >>>>>
> >>>>>
> >>>>> Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
> >>>>> this be changed to be able to support 128 StreamIDs as well?  Although I am
> >>>>> not sure if this would be too big to have on the stack per Rob's comment in
> >>>>> the previous patch set.
> >>> Do you actually need 128 now? If not, then we can deal with that when
> >>> we get there. There are lots of things in spec's that are not actually
> >>> implemented or supported.
> >>
> >> Actually, we are using 32 on the AMD system. So, do you think we can set
> >> this to 32 instead?
> >
> > I think that's ok.
> >
> > But are we really talking about number of SMRs or number of StreamIDs
> > per master device here? Ie. are you just having 32 SMRs for an SMMU on
> > your AMD system or do you have master devices which have 32 StreamIDs?
> >
> > If it's just number of SMRs we don't need to modify this macro.

> I am referring to the case where each mmu-master can have upto 32 streamID.

Rob,

Do you agree on increasing MAX_PHANDLE_ARGS to 32?

Or should this be done when someone (e.g. Suravee) submits a DTS
update with an SMMU node description containing more than 16 stream
IDs for a master device?


Andreas
