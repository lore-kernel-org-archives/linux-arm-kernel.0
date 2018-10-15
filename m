From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 15 Oct 2018 16:11:54 +0000
Subject: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
Message-ID: <AM0PR04MB42113CBC474C64ADE3B3D01780FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

> -----Original Message-----
> From: Leonard Crestez
> Sent: Monday, October 15, 2018 9:28 PM


[...]

> Subject: [PATCH v2 0/4] Port mxs-dcp to imx6ull and imx6sll
> 
> The DCP block is present on 6sll and 6ull but not enabled. The hardware is
> mostly compatible with 6sl, the only important difference is that explicit clock
> enabling is required.
> 
> There were several issues with the functionality of this driver (it didn't even
> probe properly) but they are fixed in cryptodev/master by this series:
>     https://lore.kernel.org/patchwork/cover/994874/
> 

Thanks for the work.
I will be glad to help the test if you provide some test guides. :-)

Regards
Dong Aisheng

> ---
> Changes since v1:
>  * Add devicetree maintainers for dt-bindings
>  * Add a patch enabling in imx_v6_v7_defconfig. Since tcrypt now passes this
> shouldn't cause any issues
>  * Link to v1: https://lore.kernel.org/patchwork/cover/994893/
> 
> Leonard Crestez (4):
>   dt-bindings: crypto: Mention clocks for mxs-dcp
>   crypto: mxs-dcp - Add support for dcp clk
>   ARM: dts: imx6ull: Add dcp node
>   ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP
> 
>  .../devicetree/bindings/crypto/fsl-dcp.txt     |  2 ++
>  arch/arm/boot/dts/imx6ull.dtsi                 | 10 ++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig           |  1 +
>  drivers/crypto/mxs-dcp.c                       | 18
> ++++++++++++++++++
>  4 files changed, 31 insertions(+)
> 
> --
> 2.17.1
