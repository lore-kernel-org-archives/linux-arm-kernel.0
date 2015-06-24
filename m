From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 Jun 2015 06:55:07 +0200
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <558A382B.8000601@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2015 08:00 PM, Moritz Fischer wrote:
> The Xilinx LogiCORE IP mailbox is a FPGA core that allows for
> interprocessor communication via AXI4 memory mapped / AXI4 stream
> interfaces.
> 
> It is single channel per core and allows for transmit and receive.
> 
> Changes from v4:
> - Have separate mbox_ops structs for polling / irq mode
> - Moved clk handling to startup / shutdown
> - Embedded struct mbox_chan in struct xilinx_mbox
> - Misc stylistic issues
> 
> Changes from v3:
> - Stylistic
> 
> Changes from v2:
> - Fixed error handling for IRQ from >= 0 to > 0
> - Fixed error handling for clock enabling
> - Addressed Michal's stylistic comments
> 
> Changes from v1:
> - Added common clock framework support
> - Deal with IRQs that happend before driver load,
>   since HW will not let us know about them when we enable IRQs
> 
> Changes from v0:
> - Several stylistic issues
> - Dropped superfluous intr_mode member
> - Really masking the IRQs on mailbox_shutdown
> - No longer using polling by accident in non-IRQ mode
> - Swapped doc and driver commits

BTW: These change logs shouldn't be the part of commit.

Thanks,
Michal
