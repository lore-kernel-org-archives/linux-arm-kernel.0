From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 06 Apr 2011 10:14:53 +0200
Subject: [PATCH 5/7] v4l: s5p-fimc: add pm_runtime support
In-Reply-To: <007c01cbf3f2$c6e7b420$54b71c60$%han@samsung.com>
References: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
	<1302012410-17984-6-git-send-email-m.szyprowski@samsung.com>
	<007c01cbf3f2$c6e7b420$54b71c60$%han@samsung.com>
Message-ID: <4D9C20FD.2010608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonghun,

On 04/06/2011 02:37 AM, Jonghun Han wrote:
...
> 
> Hi Marek,
> 
> runtime_pm is used to minimize current.
> In my opinion, the followings will be better.
> 1. Adds pm_runtime_get_sync before running of the first job.
>    IMO, dma_run callback function is the best place for calling in case of
> M2M.
Yeah, sounds reasonable.

> 2. And then in the ISR, call pm_runtime_put_sync in the ISR bottom-half if
> there is no remained job.

So you are switching the clocks off in the interrupt context, I'm not sure
whether this is a good idea. Perhaps we could just use pm_runtime_put()
in this case?

> 
> I had already implemented and tested.
> But it remained code cleanup. I hope I can post it on the next week.

The purpose of Marek's simple patch was to just enable the FIMC IP
to illustrate the IOMMU driver's operation. I have prepared more complete
patch for runtime PM and system suspend/resume in the mem-to-mem driver
as well, but I want to consolidate this with the video capture driver before
sending upstream.
Anyway I'm looking forward to see your patch so we can work out some common
version. Also I've got a few patches for this rc period which I intend to post
this week.

Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
