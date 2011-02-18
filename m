From: John.Linn@xilinx.com (John Linn)
Date: Thu, 17 Feb 2011 18:29:42 -0700
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <4D5D9A00.7060609@codeaurora.org>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>	<1297872716-13353-2-git-send-email-john.linn@xilinx.com>	<1297872716-13353-3-git-send-email-john.linn@xilinx.com>	<e58673f5-2881-4820-b5cd-99e8ef294ed5@VA3EHSMHS024.ehs.local>
	<20110217100126.GD22961@pulham.picochip.com>
	<4D5D9A00.7060609@codeaurora.org>
Message-ID: <8d5eb291-6a7c-4500-92e1-cdd84f4657b9@VA3EHSMHS009.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Thursday, February 17, 2011 2:58 PM
> To: Jamie Iles
> Cc: John Linn; linux at arm.linux.org.uk; arnd at arndb.de;
catalin.marinas at arm.com; linux-
> kernel at vger.kernel.org; glikely at secretlab.ca;
linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V3 3/4] ARM: Xilinx: base header files and
assembly macros
> 
> On 02/17/2011 02:01 AM, Jamie Iles wrote:
> >> +
> >> +static void putc(char ch)
> >> +{
> >> +	/*
> >> +	 * Wait for room in the FIFO, then write the char into the FIFO
> >> +	 */
> >> +	while (UART_STATUS(LL_UART_PADDR) & UART_SR_TXFULL)
> >> +		;
> >
> > It might be worth adding a barrier() call to these loops to be
explicit
> > about the volatility.
> 
> I think you want cpu_relax() then.

Thanks Stephen.

> 
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
> 


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
