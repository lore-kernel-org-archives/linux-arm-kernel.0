From: madalin.bucur@nxp.com (Madalin-cristian Bucur)
Date: Tue, 12 Jun 2018 14:27:35 +0000
Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
Message-ID: <AM6PR04MB400853DACF980BE0E117D9C6EC7F0@AM6PR04MB4008.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu at nxp.com]
> Sent: Thursday, June 7, 2018 12:21 PM
> To: netdev at vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Richard Cochran <richardcochran@gmail.com>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> David S . Miller <davem@davemloft.net>
> Cc: devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Y.b. Lu
> <yangbo.lu@nxp.com>
> Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
> 
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.
> 
> Yangbo Lu (10):
>   fsl/fman: share the event interrupt
>   ptp: support DPAA FMan 1588 timer in ptp_qoriq
>   dt-binding: ptp_qoriq: add DPAA FMan support
>   powerpc/mpc85xx: move ptp timer out of fman in dts
>   arm64: dts: fsl: move ptp timer out of fman
>   fsl/fman: add set_tstamp interface
>   fsl/fman_port: support getting timestamp
>   fsl/fman: define frame description command UPD
>   dpaa_eth: add support for hardware timestamping
>   dpaa_eth: add the get_ts_info interface for ethtool
> 
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-----
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++-
>  arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   88
> ++++++++++++++++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
>  drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
>  drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
>  drivers/net/ethernet/freescale/fman/fman.h         |    1 +
>  drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
>  drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
>  drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
>  drivers/net/ethernet/freescale/fman/fman_port.h    |    2 +
>  drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
>  drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
>  drivers/net/ethernet/freescale/fman/mac.c          |    3 +
>  drivers/net/ethernet/freescale/fman/mac.h          |    1 +
>  drivers/ptp/Kconfig                                |    2 +-
>  drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++-------
>  include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
>  26 files changed, 361 insertions(+), 115 deletions(-)

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
