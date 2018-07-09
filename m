From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 9 Jul 2018 10:37:41 +0000
Subject: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
In-Reply-To: <20180705194113.16256-2-roy.pledge@nxp.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <20180705194113.16256-2-roy.pledge@nxp.com>
Message-ID: <119c6fc6-a32d-45a5-96ea-f6e9959b1e74@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

Couple of comments inline.

On 05.07.2018 22:41, Roy Pledge wrote:
> Move the NXP DPIO (Datapath I/O Driver) out of the
> drivers/staging directory and into the drivers/soc/fsl directory.
> 
> The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
> hardware on NXP DPAA2 devices. This is a prerequisite to moving the
> DPAA2 Ethernet driver out of staging.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>   MAINTAINERS                                                    |  2 +-
>   drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-
>   drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-
>   drivers/soc/fsl/Kconfig                                        | 10 ++++++++++
>   drivers/soc/fsl/Makefile                                       |  1 +
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile          |  0
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h        |  0
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c     |  2 +-
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt   |  0

Maybe this should be converted to .rst and go in the already existing
Documentation/networking/dpaa2/?

>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c    |  2 +-
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c            |  0
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h            |  0
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c    |  2 +-
>   drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h    |  2 +-
>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++--
>   drivers/staging/fsl-mc/bus/Kconfig                             |  9 ---------
>   drivers/staging/fsl-mc/bus/Makefile                            |  2 --
>   {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h |  0
>   .../staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h  |  0
>   {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h |  0
>   20 files changed, 20 insertions(+), 20 deletions(-)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
>   rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
>   rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
>   rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
>   rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

I received feedback in the past on mc-bus that a driver should limit to 
only one public header and one private one. Would it make sense to do 
the same for dpio too?

---
Best Regards, Laurentiu
