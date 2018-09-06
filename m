From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 6 Sep 2018 12:10:58 +0100
Subject: [PATCH v2 04/40] iommu/sva: Add a mm_exit callback for device
 drivers
In-Reply-To: <d1dc28c4-7742-9c41-3f91-3fbcb8b13c1c@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-5-jean-philippe.brucker@arm.com>
 <d1dc28c4-7742-9c41-3f91-3fbcb8b13c1c@redhat.com>
Message-ID: <27b964dc-68c4-3bb3-288c-166c25864e45@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2018 14:23, Auger Eric wrote:
>> + * If the driver intends to share process address spaces, it should pass a valid
>> + * @mm_exit handler. Otherwise @mm_exit can be NULL.
> I don't get case where mm_exit is allowed to be NULL.

Right, this comment is a bit premature. Next version adds a "private
PASID" patch to allocate private address spaces per PASID (modifiable
with map/unmap). That mode doesn't require mm_exit, and I can move the
comment there

Thanks,
Jean
