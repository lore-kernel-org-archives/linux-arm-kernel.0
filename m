From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 13:48:34 +0800
Subject: [PATCH v2 1/3] ARM: imx6ull: add imx6ull support
In-Reply-To: <1478584614-12054-2-git-send-email-peter.chen@nxp.com>
References: <1478584614-12054-1-git-send-email-peter.chen@nxp.com>
 <1478584614-12054-2-git-send-email-peter.chen@nxp.com>
Message-ID: <20161114054833.GG3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:56:52PM +0800, Peter Chen wrote:
> It is the 10th processor in the well-known imx6 series, and derived
> from imx6ul but cost optimized. The more information about imx6ull
> can be found at:
> 
> http://www.nxp.com/products/microcontrollers-and-processors/
> arm-processors/i.mx-applications-processors/i.mx-6-processors
> /i.mx6qp/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core
> :i.MX6ULL
> 
> In this patch, for SoC part, the imx6ull.dtsi includes imx6ul.dtsi;
> for board part (imx6ul/imx6ull 14x14 evk), it has a common board
> file imx6u-14x14-evk.dtsi, and this file is included by both
> imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  arch/arm/boot/dts/Makefile              |   3 +-
>  arch/arm/boot/dts/imx6u-14x14-evk.dtsi  | 487 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts  | 479 +------------------------------

What's the real change between imx6u-14x14-evk.dtsi and
imx6ul-14x14-evk.dts?  Instead of renaming the file, I would like to
have imx6ull-14x14-evk.dts include imx6ul-14x14-evk.dts directly, if we
can work out the difference within imx6ull-14x14-evk.dts.

Shawn

>  arch/arm/boot/dts/imx6ull-14x14-evk.dts |  55 ++++
>  arch/arm/boot/dts/imx6ull-pinfunc.h     |  56 ++++
>  arch/arm/boot/dts/imx6ull.dtsi          |  43 +++
>  6 files changed, 644 insertions(+), 479 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6ull-14x14-evk.dts
>  create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx6ull.dtsi
