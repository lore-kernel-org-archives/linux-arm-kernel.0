From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 21 Sep 2010 01:30:16 +0100
Subject: colibri-pxa320/AX88796: phy-read/write problems
In-Reply-To: <4C9208DD.8000805@pengutronix.de>
References: <4C9208DD.8000805@pengutronix.de>
Message-ID: <4C97FC98.9080309@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/10 13:09, Marc Kleine-Budde wrote:
> Hello,
> 
> my hardware is a toradex colibri PXA320 board using latest stable
> Kernel 2.6.35.4. The Ethernet controller is a AX88796BI.
> 
> Ethernet is working, but access via MDIO to the AX's internal phy is
> broken. The contents of all registers is 0xffff.
> 
> The userspace tool "mii-diag" illustrates the problem:
> root at grabowski:~ mii-diag
> Using the default interface 'eth0'.
> Basic registers of MII PHY #16:  ffff ffff ffff ffff ffff ffff ffff ffff.
>   No MII transceiver present!.
>   Use '--force' to view the information anyway.
> 
> If I switch on the phy_debug in the ax88796 driver we see that the
> 0xffff are read via "ax_phy_read()" from the hardware, this means it's
> not a problem in the userspace.

I've not tried it with a PXA, but it was working with a S3C2440 based
system when it was written, so I do beleive it should work. However
I've not had a chance to test the MII code for a few releases so have
no idea if it does still work.

Do you know if the hardware is correct? Has any other linux version
managed to talk to the MII interface, or other OS/bootloader
combination?

-- 
Ben
