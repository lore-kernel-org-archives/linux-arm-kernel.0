From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2011 13:17:27 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <alpine.LFD.2.00.1107081417080.14596@xanadu.home>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080941090.14596@xanadu.home>
	<20110708160329.GF4812@n2100.arm.linux.org.uk>
	<4E1736A9.9040102@codeaurora.org>
	<alpine.LFD.2.00.1107081417080.14596@xanadu.home>
Message-ID: <4E1B5A57.3010701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/8/2011 11:24 AM, Nicolas Pitre wrote:
> On Fri, 8 Jul 2011, Stephen Boyd wrote:
>> Why can't this work via atags (or DT for that matter)? atags have always
>> said where ram starts and we should be able to write some code that
>> parses the atags/DT and figures out the final resting place of the
>> decompressed image.
> Possibly.  But that would be an MSM special case.
>

Hmm. I thought ST-Erricson folks had something similar.

Anyway, maybe we've been going about this the wrong way. Couldn't we
just make TEXT_OFFSET be 0x00208000 and then make sure to remove the
first 2MB of memory in a machine->reserve() routine if we're MSM?

Something like PHYS_OFFSET=0xN0000000 and TEXT_OFFSET=0x00208000 so that
our text ends up at the right place (0xN0208000) and AUTO_ZRELADDR will
be happy. This seems to work as long as I fixup the atags to say memory
starts at 0xN000000 instead of 0xN0200000.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
