From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 29 Jun 2018 09:47:19 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: 00A196A0-4E17-4320-847B-E0D54216C0DF
 00A196A0-4E17-4320-847B-E0D54216C0DF
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com> <5B34F5C0.9090001@hisilicon.com>
 <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
 <etPan.5b3507f7.914aa16.1d6b@localhost>
Message-ID: <86o9fuyo6g.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jun 2018 20:18:13 +0100,
Zhangxiquan <zhangxiquan@hisilicon.com> wrote:
> 
> [1  <text/plain; utf-8 (base64)>]
> Hi Mark ,
> 
> I clined to agree with you that DMB is enough for order of DC and LDST.
> 
> Just want to know , has this code ever passed on any ARMer
> implementation ?such ad A75,A72....

This code has been tested on most ARM implementations, as this is what
we used to develop it. So far, you have the only example we know of
where this sequence doesn't work as expected.

More importantly, this piece of code is written to match the ARMv8
architecture requirements, and we can only expect implementations to
follow the exact same requirements.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
