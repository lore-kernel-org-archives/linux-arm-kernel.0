From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 17 Mar 2014 13:31:23 -0400
Subject: [PATCH] ARM: dts: msm8974: Move arch-timer out of soc node
In-Reply-To: <1394573058-18561-1-git-send-email-sboyd@codeaurora.org>
References: <1394573058-18561-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5327316B.6040007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 03/11/2014 05:24 PM, Stephen Boyd wrote:
> The architected timer is not a register addressable piece of
> hardware. Instead it's accessed through cp15 accessors. Move it
> to the root of the devicetree to reflect this.

I find this confusing, perhaps due to overloading of the word "register".
Aren't CP15's a class of coprocessor _registers_? Could it perhaps be clearer
to talk about memory-mapped versus CP15-mapped timers?

Is "soc" documented somewhere or is it just a name for a container? Assuming
the latter, it's not obvious to me why being a child of a system on chip node
would imply having memory mapped registers.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
