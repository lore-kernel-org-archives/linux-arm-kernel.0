From: davidb@codeaurora.org (David Brown)
Date: Tue, 14 Jun 2011 14:38:37 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <alpine.LFD.2.00.1106140300500.2142@xanadu.home> (Nicolas Pitre's
	message of "Tue, 14 Jun 2011 03:09:02 -0400 (EDT)")
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612092131.GC10283@n2100.arm.linux.org.uk>
	<20110612095217.GD10283@n2100.arm.linux.org.uk>
	<20110612104215.GC29516@S2100-06.ap.freescale.net>
	<20110612104048.GE10283@n2100.arm.linux.org.uk>
	<8yaaadlfi3q.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1106131910570.2142@xanadu.home>
	<alpine.LFD.2.00.1106140300500.2142@xanadu.home>
Message-ID: <8ya8vt4ccv6.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14 2011, Nicolas Pitre wrote:

> +		} else if (atag->hdr.tag == ATAG_MEM) {
> +			uint32_t mem_reg_property[2];
> +			mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
> +			mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
> +			setprop(dt, "/memory", "reg", mem_reg_property,
> +			           sizeof(mem_reg_property));

Hopefully, I'll be able to get zImages working on MSM8x60 today, and I
can test this.  I think the above might need some work to handle
multiple ATAG_MEM attributes (our memory isn't contiguous).  I can look
at this once I get it working.

Does this mean that merging appended DTB and atags requires using a
compressed kernel?  It seems that several years ago, someone tested the
decompressor on a slow MSM and decided to boot from the uncompressed
image, and nobody has bothered with the compressed image.  I don't think
it is a problem to require zImage for this case, though.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
