From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Sep 2017 10:55:43 +0200
Subject: [PATCH  0/5] Add USB2.0 Host support
In-Reply-To: <1504100473-5528-1-git-send-email-biju.das@bp.renesas.com>
References: <1504100473-5528-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170901085543.GD14918@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 02:41:08PM +0100, Biju Das wrote:
> Hello,
> 
> This series aims to add USB2.0 Host support on iWave RZ/G1M(r8a7743)
> based board.
> 
> This series has been tested against renesas-dev tag 20170830-v4.13-rc7
> 
> This patch has documentation dependency on below patches
>  * PCI: rcar: Add r8a7743/5 support
> https://patchwork.kernel.org/patch/9919697/
>  * phy: rcar-gen2: Add r8a7743/5 support
> https://patchwork.kernel.org/patch/9919727/

Thanks for the testing and dependency information.

I see that the PCI dependency has been accepted by Bjorn Helgaas.
And the phy dependency is both trivial and has been acked by Rob Herring
so it seems very likely to be accepted.

On the strength of the above I have accepted this series for v4.15.

> 
> Biju Das (5):
>   ARM: dts: r8a7743: Add internal PCI bridge nodes
>   ARM: dts: r8a7743: Add USB PHY DT support
>   ARM: dts: r8a7743: Link PCI USB devices to USB PHY
>   ARM: dts: iwg20d-q7: Enable internal PCI
>   ARM: dts: iwg20d-q7: Enable USB PHY
> 
>  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 26 ++++++++++
>  arch/arm/boot/dts/r8a7743.dtsi          | 92 +++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> -- 
> 1.9.1
> 
