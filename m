From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Feb 2013 18:27:06 +0000
Subject: [PATCH] ARM: vfp: fix fpsid register subarchitecture field mask
 width
In-Reply-To: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
References: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130222182705.GC19527@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Fri, Feb 22, 2013 at 08:08:05AM +0000, Stephen Boyd wrote:
> From: Steve Muckle <smuckle@codeaurora.org>
> 
> The subarchitecture field in the fpsid register is 7 bits wide.
> The topmost bit is used to designate that the subarchitecture
> designer is not ARM. We use this field to determine which VFP
> version is supported by the CPU. Since the topmost bit is masked
> off we detect non-ARM subarchitectures as supporting only
> HWCAP_VFP and not HWCAP_VFPv3 as it should be for Qualcomm's
> processors.

I'm struggling to see why this has anything to do with the hwcaps being set
incorrectly. What value do you have in fpsid? As far as I can tell, the
subarchitecture bits 6:0 should start at 0x40 for you, right?

I can see cases for changing this code, I just don't see why it would go
wrong in the case you're describing.

Cheers,

Will
