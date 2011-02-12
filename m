From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Feb 2011 13:32:48 -0500 (EST)
Subject: The p2v branch
Message-ID: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I finally was able to complete this series and test it satisfactorily.  
This required some hacking to the OMAP UART debugging code so it would 
stop fighting against me and forcefully collaborate.

Now that I've got a PandaBoard I'm getting rather grumpy with some of 
that code...  Some patches touching that area from me are to be expected 
in the near future.

But in the mean time I think you can complete the p2v branch with the 
following:

3ecf8ba5 ARM: P2V: eliminate head.S use of PHYS_OFFSET for !XIP_KERNEL
Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

5e8e98cd ARM: P2V: introduce phys_to_virt/virt_to_phys runtime patching
Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>

1929d11e ARM: P2V: extend to 16-bit translation offsets
Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
(forced it on with non-msm targets for testing)

b7a0fbb4 ARM: 6648/1: map ATAGs when not in first 1MB of RAM
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

I also have 2 additional patches for this branch to follow:

[PATCH 1/2] ARM: ignore mdesc->boot_params if out of range
[PATCH 2/2] ARM: P2V: Thumb2 support


Nicolas
