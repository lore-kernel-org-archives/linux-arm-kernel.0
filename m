From: davidb@codeaurora.org (David Brown)
Date: Tue, 19 Jul 2011 13:42:52 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <alpine.LFD.2.00.1107191356500.21187@xanadu.home>
References: <4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080941090.14596@xanadu.home>
	<20110708160329.GF4812@n2100.arm.linux.org.uk>
	<4E1736A9.9040102@codeaurora.org>
	<alpine.LFD.2.00.1107081417080.14596@xanadu.home>
	<4E1B5A57.3010701@codeaurora.org>
	<alpine.LFD.2.00.1107111803520.14596@xanadu.home>
	<20110719172201.GA4557@huya.qualcomm.com>
	<alpine.LFD.2.00.1107191356500.21187@xanadu.home>
Message-ID: <20110719204252.GA4551@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 02:02:27PM -0400, Nicolas Pitre wrote:

> > What about loading the kernel at the next 128MB boundary,
> > and coming up with a way to use the 126MB before the kernel for
> > allocation.  That might end up being more invasive, though.
> 
> Indeed. And many targets don't even have that amount of memory.

I wasn't thinking that anything other than MSM would change.  The
kernel would be at a 128MB+0x8000 boundary.  Non-MSM targets would
stay the same, and MSM targets would have the kernel 128MB further in
memory, and reclaim that memory later.

Probably not the best way to do it, and it sounds like Stephen Boyd
has some better ideas, anyway.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
