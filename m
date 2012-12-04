From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Dec 2012 14:45:01 -0500
Subject: [PATCH] arm: mvebu: Use dw-apb-uart instead of ns16650 as UART
 driver
In-Reply-To: <50BE2E22.6020606@free-electrons.com>
References: <1354640699-6066-1-git-send-email-gregory.clement@free-electrons.com>
 <50BE2E22.6020606@free-electrons.com>
Message-ID: <20121204194501.GT12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 06:08:50PM +0100, Gregory CLEMENT wrote:
> On 12/04/2012 06:04 PM, Gregory CLEMENT wrote:
> > The UART controller used in the Armada 370 and Armada XP SoCs is the
> > Synopsys DesignWare 8250 (aka Synopsys DesignWare ABP UART). The
> > improper use of the ns16550 can lead to a kernel oops during boot if
> > a character is sent to the UART before the initialization of the
> > driver. The DW APB has an extra interrupt that gets raised when
> > writing to the LCR when busy. This explains why we need to use
> > dw-apb-uart driver to handle this.
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> > 
> > This patch fixed a bug introduced in 3.7, but as there are very few
> > boards supported in 3.7 (only the Armada 370 and Armada XP evaluation
> > boards), it is not a big deal if this patch is only applied for 3.8.

mirabox, openblocks A3/4, but your point still stands.

> > This patch is based on 3.7-rc8 and can be applied on top of the
> > current arm-soc/for-next with a trivial conflict on mvebu_defconfig.
> > 
> 
> Jason,
> 
> do you want a git pull, or is it easier to just pick this single patch?

nah, I'll just queue it up for v3.8-rc1

thx,

Jason.
