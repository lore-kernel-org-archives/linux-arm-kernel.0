From: davidb@codeaurora.org (David Brown)
Date: Tue, 19 Jul 2011 10:22:01 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <alpine.LFD.2.00.1107111803520.14596@xanadu.home>
References: <4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080941090.14596@xanadu.home>
	<20110708160329.GF4812@n2100.arm.linux.org.uk>
	<4E1736A9.9040102@codeaurora.org>
	<alpine.LFD.2.00.1107081417080.14596@xanadu.home>
	<4E1B5A57.3010701@codeaurora.org>
	<alpine.LFD.2.00.1107111803520.14596@xanadu.home>
Message-ID: <20110719172201.GA4557@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 06:14:38PM -0400, Nicolas Pitre wrote:

> > Anyway, maybe we've been going about this the wrong way. Couldn't we
> > just make TEXT_OFFSET be 0x00208000 and then make sure to remove the
> > first 2MB of memory in a machine->reserve() routine if we're MSM?
> 
> I think that would certainly be a worthwhile thing to do.  This would 
> even make ARM_PATCH_PHYS_VIRT more efficient as you won't have to enable 
> ARM_PATCH_PHYS_VIRT_16BIT anymore.  And even without 
> ARM_PATCH_PHYS_VIRT, the compiled code for virt_to_phys() and 
> phys_to_virt() would be more efficient.
> 
> Whether or not we would like to still keep the ARM_PATCH_PHYS_VIRT_16BIT 
> code around is a separate question.

Wouldn't it still be needed if people want to build an ARM kernel that
works on both MSM targets and non-MSM targets?

What about loading the kernel at the next 128MB boundary,
and coming up with a way to use the 126MB before the kernel for
allocation.  That might end up being more invasive, though.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
