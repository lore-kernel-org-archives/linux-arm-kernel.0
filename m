From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Feb 2013 09:44:27 -0800
Subject: [PATCH] ARM: vfp: fix fpsid register subarchitecture field mask
 width
In-Reply-To: <20130226175439.GT17833@n2100.arm.linux.org.uk>
References: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
 <20130222182705.GC19527@mudshark.cambridge.arm.com>
 <5128034A.4000008@codeaurora.org>
 <20130225111835.GA24254@mudshark.cambridge.arm.com>
 <512C2577.3030202@codeaurora.org>
 <20130226175439.GT17833@n2100.arm.linux.org.uk>
Message-ID: <512E45FB.90204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/13 09:54, Russell King - ARM Linux wrote:
> What I actually need from you is: for the Qualcomm implementation, what
> are the subarch bits defined as, and what do they correspond with - both
> the VFP version, and whether they correspond with any ARM common VFP
> subarchitecture version.

For the Qualcomm implementation, the subarch bits have always been 0x40
so far. And they are compatible with "VFPv3 architecture or later with
common VFP subarchitecture v3". In your table below it would be the last
row.

>
> In ARM land, these are the possiblities - I've also listed those
> platforms which I definitely know of at the moment which use the
> particular version combination:
>
> VFP version	VFP subarch
> V1		-
> V2		V1		Raspberry Pi
> V3		V2		Marvell Dove (Cubox) (though, not ARM)
> V3		NULL		OMAP3430 / OMAP4430
> V3		V3

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
