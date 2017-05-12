From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 12 May 2017 05:12:57 +0000
Subject: Armada SoC Error Reporting Interrupts
Message-ID: <afb8f5ea4fe84857bff3f73255685d4d@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi List,

Has anyone looked at the SoC Error Reporting Interrupts for the 
Armada-385 or Armada-XP?

I want to enable some error reporting for ECC errors on the DRAM 
interface and it looks like the mv64x60_edac driver should work with a 
few tweaks to use generic I/O accessors and to add a device-tree 
of_device_id table.

The problem I'm currently grappling with is that for it to do it's job 
it needs to get the DRAMErr interrupt. This is located in the 
"Proprietary Interrupt Controller Errors" section but I'm struggling 
with how to map this through. Is this something that should already be 
mapped or do I need to add and irqchip driver for it?

Thanks,
Chris
