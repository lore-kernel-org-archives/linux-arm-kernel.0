From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jul 2017 09:41:43 +0100
Subject: [PATCH 0/8] io-pgtable lock removal
In-Reply-To: <2d5f5ef3-32b1-76c6-6869-ff980557f8e8@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
 <458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
 <b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
 <cdc1799b-f142-09ed-a7e5-d7fd2e70268f@arm.com>
 <e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
 <20170628114609.GD11053@arm.com>
 <87d53115-3d80-5a3d-6632-c31986cb7018@broadcom.com>
 <20170704173155.GN22175@arm.com>
 <6814b246-22f0-bfaa-5002-a269b2735116@broadcom.com>
 <2d5f5ef3-32b1-76c6-6869-ff980557f8e8@broadcom.com>
Message-ID: <20170705084143.GA9378@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 06:45:17PM -0700, Ray Jui wrote:
> Hi Will/Robin,
> 
> Has anything functionally changed between PATCH v2 and v1? I'm seeing a
> very different L2 throughput with v2 (in general a lot worse with v2 vs.
> v1); however, I'm currently unable to reproduce the TLB sync timed out
> issue with v2 (without the patch from Will's email).
> 
> It could also be something else that has changed in my setup, but so far
> I have not yet been able to spot anything wrong in the setup.

There were fixes, and that initially involved a DSB that was found to be
expensive. The patches queued in -next should have that addressed, so please
use those (or my for-joerg/arm-smmu/updates branch).

Will
