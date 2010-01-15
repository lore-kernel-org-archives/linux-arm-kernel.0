From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jan 2010 21:26:26 +0000
Subject: [RFC 03/18] arm: boot: remove old ARM ID for QSD
In-Reply-To: <1263250057-26692-4-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-4-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100115212625.GA28222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:22PM -0800, Daniel Walker wrote:
> From: Steve Muckle <smuckle@quicinc.com>
> 
> The mask and ID pattern for older ARM IDs in the kernel
> decompressor matches the CPU ID for Scorpion, causing the
> v7 caching routines not to be run and kernel decompression
> to take significantly longer.
> 
> QSD may eventually use CPUs other than Scorpion, but they
> will adhere to the new ARM CPU ID format, which is
> incompatible with the entry for older ARM CPU IDs.

Actually, we need to change this.

> +#ifndef CONFIG_ARCH_MSM_SCORPION
>  		.word	0x00000000		@ old ARM ID
>  		.word	0x0000f000

		.word	0x41000000		@ old ARM ID
		.word	0xff00f000

would be more appropriate - but I don't know if this means we'll miss
out on some CPUs.  However, the latest spec indicates that this is
how it should be for matching ARMv2 and v3 architectures.
