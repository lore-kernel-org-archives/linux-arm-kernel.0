From: dacohen@gmail.com (David Cohen)
Date: Thu, 18 Aug 2011 16:40:38 +0300
Subject: [PATCH 6/7] omap: iommu: remove unused exported API
In-Reply-To: <CAK=Wgba0_4W=vODss4+ZKE=PQL266+W0+vb3MiwsTqQH4_1_LQ@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-7-git-send-email-ohad@wizery.com>
	<20110818.134947.522985871882962246.Hiroshi.DOYU@nokia.com>
	<CAK=Wgba0_4W=vODss4+ZKE=PQL266+W0+vb3MiwsTqQH4_1_LQ@mail.gmail.com>
Message-ID: <CAPqfFkAvk92oK-7jhbVZk9zSR7Q1w1CiPLO1PL8xq3E0n1rz-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Thu, Aug 18, 2011 at 2:01 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Hiroshi,
>
> On Thu, Aug 18, 2011 at 1:49 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>>> -extern void iommu_set_twl(struct iommu *obj, bool on);
>>
>> This function was introduced by "Hari Kanigeri" for some OMAP4 case,
>> which is only using TLB, not H/W table walk.
>
> We discussed that internally, and concluded it's not needed anymore. I
> still kept the underlying plumbing mechanism, just in case it'd still
> be needed for some hw quirks in the future, but removed the interface
> (in case a future hw revision will seem to need it, it would probably
> make more sense to invoke the relevant mechanism from the underlying
> layers rather than from a higher layer).
>
>>> -extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
>>
>> This function was introduced by "David Cohen" to specify the available
>> ISP virtual address range.

This function wasn't actually introduced by me, but I remember to refer it
when I was discussing to not define address 0x0 as valid in da range by
default (unless intentionally specified by client).

>
> Not sure if David or anyone is using this, but if someone is, it must
> be out-of-tree.

I am fine to remove it.

Br,

David

>
> In that case, even if it is needed, adding a mainline user for this
> function at this point will most likely not be accepted anymore, and
> instead, one will be suggested to use (and extend as necessary) the
> DMA-API.
>
> Thanks,
> Ohad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
