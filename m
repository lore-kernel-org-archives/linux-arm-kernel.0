From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 18:41:38 +0000
Subject: The p2v branch
In-Reply-To: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
Message-ID: <20110212184138.GD22402@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 01:32:48PM -0500, Nicolas Pitre wrote:
> I finally was able to complete this series and test it satisfactorily.  
> This required some hacking to the OMAP UART debugging code so it would 
> stop fighting against me and forcefully collaborate.

It should at least build with 6651/1 in place.  The only fight
remaining is against the (imho misguided) attempt to select the debug
port based on the machine ID.  I normally end up hard-coding the
addresses.

> But in the mean time I think you can complete the p2v branch with the 
> following:
> 
> 3ecf8ba5 ARM: P2V: eliminate head.S use of PHYS_OFFSET for !XIP_KERNEL
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> 5e8e98cd ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> 1929d11e ARM: P2V: extend to 16-bit translation offsets
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> (forced it on with non-msm targets for testing)
> 
> b7a0fbb4 ARM: 6648/1: map ATAGs when not in first 1MB of RAM
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Added.
