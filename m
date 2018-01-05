From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:39:04 -0800
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.16
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <20180105063904.ub6gulilm3c6xzr7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 11:29:20AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.16.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.16,
> which you have already pulled.
> 
> 
> The following changes since commit 8aba250d7800702bbd2f6a91174e01b9a84ed2dd:
> 
>   arm64: dts: renesas: r8a77970: use SYSC power domain macros (2017-12-05 09:30:48 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.16
> 
> for you to fetch changes up to 68b2c029e6200933fa3f6c06c8e6de33e8c78c51:
> 
>   arm64: dts: renesas: salvator-common: enable usb3_peri0 (2017-12-21 10:22:12 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.16
> 
> * Add usb3_phy node to r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W) SoCs, and
>   enable usb3_peri0 on salvator boards
> 
> * Allow DTBs of boards of r8a7795 (R-Car H3) and r8a7796 SoCs to build
>   without any warnings when compiled with W=1 using gcc-linaro-5.4.1-2017.05
>   - Move nodes which have no reg property out of bus, they don't belong there
>   - Add reg properties to dummy pciec[01] nodes
>   - Also sort sub-nodes of root node to allow for easier maintenance
> 
> * Add Add EthernetAVB PHY reset to r8a7795 (R-Car H3) and r8a7796 SoCs boards.
> 
>   Geert Uytterhoeven says "... add properties to describe the EthernetAVB
>   PHY reset topology to the common Salvator-X/XS and ULCB DTS files, which
>   solves two issues:
>     1. On Salvator-XS, the enable pin of the regulator providing PHY power
>        is connected to PRESETn, and PSCI powers down the SoC during system
>        suspend.  Hence a PHY reset is needed to restore network
>        functionality after system resume.
>     2. Linux should not rely on the boot loader having reset the PHY, but
>        should reset the PHY during driver probe."
> 

Merged, thanks.


-Olof
