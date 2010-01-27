From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 26 Jan 2010 19:26:53 -0700 (MST)
Subject: [PATCH 13/14] omap2/3: Fix powerdomain init for multiomap
In-Reply-To: <20100126201306.15382.7409.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201306.15382.7409.stgit@baageli.muru.com>
Message-ID: <alpine.DEB.2.00.1001261924420.18597@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, 26 Jan 2010, Tony Lindgren wrote:

> Otherwise we'll an error when booting a kernel with both
> CONFIG_ARCH_OMAP2 and CONFIG_ARCH_OMAP3 compiled in:
> 
> Unhandled fault: imprecise external abort (0xc06) at 0x00000000
> ...
> 
> Note that the same problem may still exist when trying to boot
> a kernel with 2420 and 2430 both compiled in. We currently cannot
> test this as the clock framework needs updating to support booting
> 2420 and 2430 compiled in.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch shouldn't be needed after merging the clock-related patches 
queued up for 2.6.34; one of those patches inadvertently fixes the 
underlying problem (_pwrdm_setup() called even if pwrdm_register() fails 
due to commit ba20bb126940ce4847e146a0d00b7f7b0868d773).

Thanks for all the debugging time that you put into tracking this one 
down,

- Paul
