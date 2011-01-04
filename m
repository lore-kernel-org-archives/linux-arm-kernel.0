From: davidb@codeaurora.org (David Brown)
Date: Tue, 04 Jan 2011 15:18:46 -0800
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Tue, 04 Jan 2011 20:23:38 +0000")
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
Message-ID: <8yabp3wfeax.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04 2011, Russell King - ARM Linux wrote:

> MSM's memory is aligned to 2MB, which is more than we can do with our
> existing method as we're limited to the upper 8 bits.  Extend this by
> using two instructions to 16 bits, automatically selected when MSM is
> enabled.

I should also add that this series adds a warning to my build when
CONFIG_ARM_PATCH_PHYS_VIRT is not defined:

  arch/arm/kernel/module.c:279: error: 'find_mod_section' defined but not used

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
