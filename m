From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 12 Feb 2018 18:17:13 +0000
Subject: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
In-Reply-To: <20180207143255.17003-3-marc.zyngier@arm.com>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
 <20180207143255.17003-3-marc.zyngier@arm.com>
Message-ID: <d10fa874-1de2-1b95-dae1-42a336b98fa2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/18 14:32, Marc Zyngier wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Juno's GICv2m implementation consists of four frames providing 32
> interrupts each. Since it is possible to plug in enough PCIe endpoints
> to consume more than 32 MSIs, and the driver already has a bodge to
> handle multiple frames, let's expose the other three as well.
> 

Change on it own looks good. So if you want to merge via your tree:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Let me know if you decide not to take it via your tree and you want me
to send it to arm-soc.

On the side note I just noticed the Juno TRM[1] has 64k for each of
these MSI frames(page 3-24 section 3.3.5 Application memory map summary)

I am not sure if TRM is wrong. This patch is just copying the 4k size
from frame 0 which got added with initial Juno DTS.

-- 
Regards,
Sudeep

[1]
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515f/DDI0515F_juno_arm_development_platform_soc_trm.pdf
