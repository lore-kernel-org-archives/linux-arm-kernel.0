From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:38:13 -0700
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.19
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <20180721213813.mhdvvqgywdd64kce@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 02:03:40PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates for v4.19.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.19,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 6b284a81307848b4331453b02cf7a33c09719d4b:
> 
>   arm64: dts: renesas: r8a77995: Add MSIOF device nodes (2018-06-25 15:30:39 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.19
> 
> for you to fetch changes up to 9a6c158f62ccdd37c921ec8b1484418bad5f7984:
> 
>   arm64: dts: renesas: r8a77980: add INTC-EX support (2018-07-20 13:47:34 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.19
> 
> Corrections:
> 
> * Remove non-existing STBE region from Ether-AVB node in DT of
>   R-Car E3 (r8a77990) SoC
> 
>   This region does not exist on this SoC

I think the item is clear, no need for this additional line.

> Cleanups:
> 
> * Consistently use rwdt as label for Renesas Watchdog Timer devices
> 
> * Add second port to rcar_sound placeholder in DT of R-Car M3-N (r8a77965) SoC
> 
>   Nodes with #address-cells/#size-cells should have more than one child node

Not sure what you mean here -- it's perfectly legal to have only one child
node.

> * Fix adv7482 decimal unit addresses in DT of Salvator-X and -XS boards
> 
>   Addresses are assumed to be hex by dtc, thus it is not valid to use
>   decimal

Again, the item is clear enough.

> Enhancements:
> 
> * Describe in DT:
>   - INTC-EX of R-Car V3H (r8a77980) SoC
>   - USB3.0 of R-Car E3 (r8a77980) SoC
>   - All SCIF and HSCIF devices of R-Car D3 (r8a77995) SoC.
>     Previously only SCIF2, used as the debug consile, was described.
>   - All IPMMU devicesof R-Car M3-N (r8a77965), V3H (r8a77980) and
>     E3 (r8a77990) SoCs
> 
> * Enable USB3.0 in DT of R-Car E3 (r8a77980) based Ebisu board
> 
> * Prefer HSCIF1 over SCIF1 in DT of Salvator-X and -XS boards
> 
>   HSCIF is superior to SCIF (larger FIFOs, more accurate and wider
>   supported range of bitrates).

Sounds good.


Merged the branch with some minor tag tweaks per above.


-Olof
