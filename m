From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jan 2013 21:08:09 +0000
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <20130131163814.GE20242@lunn.ch>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <20130131162254.GD20242@lunn.ch> <20130131163814.GE20242@lunn.ch>
Message-ID: <201301312108.10046.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013, Andrew Lunn wrote:
> I did a bit of googling:
> 
> http://www.linleygroup.com/newsletters/newsletter_detail.php?num=3982
> 
>         To address the cloud-computing market, the company added
>         40-bit physical addressing to Armada XP, using a method
>         similar to what ARM implemented in Cortex-A15. This feature
>         allows the memory controller to support up to one terabyte
>         (1TB) of DRAM.
> 
> Also:
> 
> http://www.theregister.co.uk/2012/10/24/dell_zinc_arm_server_apache_software/
> 
> talks about 40-bit.
> 
> So it should be possible to use the full 4GBytes of RAM, in theory.

But is it actually using the same page table layout as LPAE or just
something "similar"?

Note that there is also 36-bit addressing in certain CPUs, which is
far less useful in general, but which could actually help here if you
can remap the MMIO registers above 4GB to free up the 32-bit space
for RAM.

	Arnd
