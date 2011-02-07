From: John.Linn@xilinx.com (John Linn)
Date: Mon, 7 Feb 2011 13:55:44 -0700
Subject: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <20110207205419.GE5853@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<eee52c43-76da-4e47-9f40-4a2d7ee963b6@VA3EHSMHS032.ehs.local>
	<20110205161853.GC29411@n2100.arm.linux.org.uk>
	<b3e8c7d4-4db6-41a7-aa06-67c8e327e2aa@VA3EHSMHS005.ehs.local>
	<20110207205419.GE5853@n2100.arm.linux.org.uk>
Message-ID: <66898d1a-1ff1-449c-afab-3d42272714a7@VA3EHSMHS003.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, February 07, 2011 1:54 PM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; kernel at vger.kernel.org;
catalin.marinas at arm.com;
> glikely at secretlab.ca
> Subject: Re: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
> 
> On Mon, Feb 07, 2011 at 08:44:11AM -0700, John Linn wrote:
> > It's interesting as I'm looking at this further.  Sure enough it
looks
> > to me like any early mappings in the MMU get destroyed.  Paging_init
calls
> > devicemaps_init which says
> > it destroys the early debug mappings.  Maybe I'm misinterpreting
that?
> 
> I don't think so.  Normally, platforms end up mapping it as part of a
> larger mappign.  If you don't have that then it'll be necessary.

Thanks, appreciate the feedback. Makes sense.

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
