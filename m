From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 15 Dec 2015 20:24:41 +0300
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <1843454.zCnLJtF7B6@wuerfel>
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <7496839.vMjVcqPe8Q@wuerfel> <1450197727.21989.9.camel@gmail.com>
 <1843454.zCnLJtF7B6@wuerfel>
Message-ID: <1450200281.21989.24.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-15 at 18:02 +0100, Arnd Bergmann wrote:
> On Tuesday 15 December 2015 19:42:07 Sergei Ianovich wrote:
> > There are several board-specific devices on LP8x4x: custom FPGA,
> > custom
> > UART, custom IRQ on FPGA, custom parallel bus for industrial IO. The
> > defconfig file could alert potential users to this fact. If this is
> > not
> > a sufficient reason to have a defconfig file, it can be dropped.
> > 
> > I use the full .config anyway 
> 
> I would like those drivers to be enabled in some defconfig, so we get
> compile-time coverage, but we generally stopped having one-config-per-
> board
> files.
> 
> Maybe we can have a pxa_defconfig file that enables lots of boards
> and then we remove the individual configs? We don't have to remove
> them all at once, but it would make me very happy if we could at
> least kill off some of the ones that are not used regularly.

lp8x4x seems to be the first pxa board which requires DT.

We can create pxa27x-dt_defconfig which selects:
1. PXA27X_DT
2. PXA_FB and 8250_PXA to enable console
3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
4. all optional pxa stuff as modules
5. all stuff on supported pxa boards as modules

If #5 is extended when support for new boards is added, it should be
possible to run any supported pxa27x board with pxa27x_defconfig.
