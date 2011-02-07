From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 20:54:19 +0000
Subject: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <b3e8c7d4-4db6-41a7-aa06-67c8e327e2aa@VA3EHSMHS005.ehs.local>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<eee52c43-76da-4e47-9f40-4a2d7ee963b6@VA3EHSMHS032.ehs.local>
	<20110205161853.GC29411@n2100.arm.linux.org.uk>
	<b3e8c7d4-4db6-41a7-aa06-67c8e327e2aa@VA3EHSMHS005.ehs.local>
Message-ID: <20110207205419.GE5853@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 08:44:11AM -0700, John Linn wrote:
> It's interesting as I'm looking at this further.  Sure enough it looks
> to me like any early mappings in the MMU get destroyed.  Paging_init calls
> devicemaps_init which says 
> it destroys the early debug mappings.  Maybe I'm misinterpreting that?

I don't think so.  Normally, platforms end up mapping it as part of a
larger mappign.  If you don't have that then it'll be necessary.
