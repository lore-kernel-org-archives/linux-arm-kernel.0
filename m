From: John.Linn@xilinx.com (John Linn)
Date: Tue, 8 Feb 2011 07:08:14 -0700
Subject: [PATCH 4/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110208082725.GA20822@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-4-git-send-email-john.linn@xilinx.com>
	<a45cf64b-c91a-4f8b-a121-5a675daee4ca@VA3EHSMHS006.ehs.local>
	<20110205164325.GE29411@n2100.arm.linux.org.uk>
	<8718a09f-604a-41b0-8b5a-856bacac9e9a@VA3EHSMHS025.ehs.local>
	<20110208082725.GA20822@n2100.arm.linux.org.uk>
Message-ID: <735942c6-d2d5-4ef0-96e7-37a477507abc@VA3EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, February 08, 2011 1:27 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
glikely at secretlab.ca
> Subject: Re: [PATCH 4/4] ARM: Xilinx: base header files and assembly
macros
> 
> On Mon, Feb 07, 2011 at 05:14:13PM -0700, John Linn wrote:
> > I'm assuming you meant to change all addresses of devices (#defines)
to
> > use the IOMEM.
> >
> > I did that and it's ok. You also have to cast them to ints when
putting
> > the addresses into
> > the resource for a platform device.
> 
> Hang on.  The reason I mentioned it was because you were passing some
> of these into readl() et.al.  readl() takes the mapped cookie, not the
> physical address.
> 
> Physical addresses should be integer like, virtual addresses should be
> pointer like.

Thanks for clarifying.

It seems like it's better to leave the #defines without IOMEM, then use
IOMEM where a variable, 
such as the address of the timer, is initialized with the #define.

I see what you mean with regard to readl taking the cookie but yet
physical addresses are also
needed.

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
