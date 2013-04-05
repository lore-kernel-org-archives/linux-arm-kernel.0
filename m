From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 22:41:14 +0200
Subject: [PATCH v2 1/9] arm: mvebu: Limit the DMA zone when LPAE is
 selected
In-Reply-To: <1365193444-13441-2-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <1365193444-13441-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201304052241.14865.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Gregory CLEMENT wrote:
> When LPAE is activated on Armada XP, all registers and IOs are still
> 32bit, the 40bit extension is on the CPU to DRAM path (windows) only.
> That means that all the DMA transfer are restricted to the low 32 bits
> address space. This is limitation is achieved by selecting ZONE_DMA.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Shouldn't that be ZONE_DMA32?

	Arnd
