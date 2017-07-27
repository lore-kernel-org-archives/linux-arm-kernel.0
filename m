From: anup.patel@broadcom.com (Anup Patel)
Date: Thu, 27 Jul 2017 10:25:25 +0530
Subject: [PATCH 2/6] dma: bcm-sba-raid: Peek mbox when we are left with no
 free requests
In-Reply-To: <20170726171028.GJ3053@localhost>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
 <1501047404-14456-3-git-send-email-anup.patel@broadcom.com>
 <20170726171028.GJ3053@localhost>
Message-ID: <CAALAos_+ba+fg8wiqtgzWdf3L554G_jW83-J7jFoDNni5_yS9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 10:40 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Jul 26, 2017 at 11:06:40AM +0530, Anup Patel wrote:
>> We should peek mbox channels when we are left with no free
>> sba_requests in sba_alloc_request()
>
> and why is the world should we do that, how does that help??

When setting up RAID array on several NVMe disk we observed
that sba_alloc_request() start failing (due to no free requests left)
and RAID array setup becomes very slow.

Doing mbox channel peek when we have no free requests left,
improves performance of RAID array setup.

This change is inspired from mv_chan_alloc_slot() implemented
in drivers/dma/mv_xor.c

Regards,
Anup
