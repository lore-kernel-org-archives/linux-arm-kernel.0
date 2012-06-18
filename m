From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 18 Jun 2012 23:41:43 +0200
Subject: Dove clock support (was: Re: RFC: [PATCH] ARM: Kirkwood:
 clk_register_gate_fn: add fn assignment)
In-Reply-To: <20120618084300.GL4799@lunn.ch>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch>
Message-ID: <20120618214143.GA20040@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:43:00AM +0200, Andrew Lunn wrote:
> > Sure, the address layout is different, but that can be made generic in a
> > second step. Maybe we need a private pointer in the gate_fn struct.
> 
> Yes, something like that.
>  
> > BTW: who will enable the clocks that have been disabled via the
> > sata/pcie shutdown functions?
> 
> This is potentially a problem when the SATA driver is built as a
> kernel module. There is no code that i know of to turn the SATA PHYs
> back on again. I think this has been broken like this for a long
> time...
> 

This is not potentially a problem, this is definitively a problem (on kirkwood):

[   12.280783] sata_mv sata_mv.0: cannot get optional clkdev                    
[   12.286314] sata_mv sata_mv.0: slots 32 ports 2                              
[   12.304443] scsi0 : sata_mv                                                  
[   12.307836] scsi1 : sata_mv                                                  
[   12.310804] ata1: SATA max UDMA/133 irq 21                                   
[   12.314920] ata2: SATA max UDMA/133 irq 21                                   
[   12.665882] ata1: SATA link down (SStatus 0 SControl F300)                   
[   13.015881] ata2: SATA link down (SStatus 0 SControl F300)                   


- Simon
