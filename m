From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Dec 2015 15:09:09 +0000
Subject: [PATCH 2/4] arm64: dts: Foundation model: increate GICC region
 to allow EOImode=1
In-Reply-To: <1444729069-27922-3-git-send-email-andre.przywara@arm.com>
References: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
 <1444729069-27922-3-git-send-email-andre.przywara@arm.com>
Message-ID: <56684415.40806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Andre,

On 13/10/15 10:37, Andre Przywara wrote:
> Recent commits made the GIC driver use EOImode=1 for all GICs
> that advertise the proper GICC region size.
> To let the model benefit from the blessings of that mode, increase
> the GICC region to its actual size of 8K.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

The patch looks good, but the commit log is slightly confusing. Apart
from the typo in the title ("increate"), it would be better to say
something like:

"The Foundation model GIC mapping is wrong, as the GICC region should be
8kB instead of 4kB (the model implements the GICv2 architecture). This
defect prevents the driver from switching to EOImode==1."

Or something similar.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
