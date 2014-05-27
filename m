From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 27 May 2014 13:15:46 -0700
Subject: [PATCH v6 2/4] live migration support for initial write protect of
 VM
In-Reply-To: <20140527195803.GB16428@lvm>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-3-git-send-email-m.smarduch@samsung.com>
 <20140527195803.GB16428@lvm>
Message-ID: <5384F272.9020401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,
 I was out traveling last week + holiday.

You had lots of comments in last version (incl. below), reworking to submit a 
new series. Un-clutter from basic issues, and update current logic. In next 
couple days I'll submit new  series.

Also looking into a wiki to document test env (but may windup with a github link).

Thanks,
  Mario



On 05/27/2014 12:58 PM, Christoffer Dall wrote:
> On Thu, May 15, 2014 at 11:27:29AM -0700, Mario Smarduch wrote:
>> Patch adds memslot support for initial write protection and split up of huge 
>> pages
> 
> I lost track of where we are with these patches, but I see a lot of
> issues in this patch that I believe I already commented on (but I may
> not have had time to comment before you sent out v6).
> 
> In any case, I'm going to wait with reviewing things carefully until you
> send out a v7, but for v7:
>  - Please document the rationale and design behind what you're doing in
>    the commit text of each patch.  Each of these patches are quite
>    large, but the commit messages are barely two lines.  I suggest you
>    take a look at 'git log arch/arm/kvm' for example to get a feel for
>    what I'm looking for.
> 
>  - There is nothing specific in the interface to KVM discussing
>    migration or live migration, it is only used as an example for
>    features in trying to stay generic.  Please use similar generic
>    concepts in the kernel to make things coherent.  'git grep
>    migration arch/x86/kvm' also tells you that x86 gets away with full
>    support for live migration without referring to migration except as
>    examples of how features might be useful.
> 
> Thanks for the work, looking forward to seeing a new revision.
> 
> -Christoffer
> 
