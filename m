From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue, 14 Mar 2017 15:57:34 +0100
Subject: [GIT PULL] generic TEE subsystem for v4.12
Message-ID: <20170314145305.GA12937@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please consider this pull request for v4.12

This pull request contains version 16 of the generic TEE driver.

The TEE subsystem will contain drivers for various TEE implementations.
A TEE (Trusted Execution Environment) is a trusted OS running in some
secure environment, for example, TrustZone on ARM CPUs, or a separate
secure co-processor etc.

The patch set has been reviewed by different people during the different
versions. Now I think this has reached a state where it's mature enough
to merge.

The v16 cover letter containing detailed revision history can be found at
https://lkml.org/lkml/2017/3/10/1277

Thanks,
Jens

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.12

for you to fetch changes up to 14e21cb8f811100a2104e952b8f5bc0326a5e213:

  arm64: dt: hikey: Add optee node (2017-03-10 14:51:58 +0100)

----------------------------------------------------------------
Introduce generic TEE subsystem:
- the TEE subsystem itself
- an OP-TEE driver using the subsystem
- optee bindings
- optee node for hi6220-hikey.dts

----------------------------------------------------------------
Jens Wiklander (4):
      dt/bindings: add bindings for optee
      tee: generic TEE subsystem
      tee: add OP-TEE driver
      Documentation: tee subsystem and op-tee driver

Jerome Forissier (1):
      arm64: dt: hikey: Add optee node

 Documentation/00-INDEX                             |   2 +
 .../bindings/arm/firmware/linaro,optee-tz.txt      |  31 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/tee.txt                              | 118 +++
 MAINTAINERS                                        |  13 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   7 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/tee/Kconfig                                |  18 +
 drivers/tee/Makefile                               |   5 +
 drivers/tee/optee/Kconfig                          |   7 +
 drivers/tee/optee/Makefile                         |   5 +
 drivers/tee/optee/call.c                           | 444 ++++++++++
 drivers/tee/optee/core.c                           | 622 ++++++++++++++
 drivers/tee/optee/optee_msg.h                      | 418 ++++++++++
 drivers/tee/optee/optee_private.h                  | 183 +++++
 drivers/tee/optee/optee_smc.h                      | 450 +++++++++++
 drivers/tee/optee/rpc.c                            | 396 +++++++++
 drivers/tee/optee/supp.c                           | 273 +++++++
 drivers/tee/tee_core.c                             | 893 +++++++++++++++++++++
 drivers/tee/tee_private.h                          | 129 +++
 drivers/tee/tee_shm.c                              | 358 +++++++++
 drivers/tee/tee_shm_pool.c                         | 156 ++++
 include/linux/tee_drv.h                            | 277 +++++++
 include/uapi/linux/tee.h                           | 346 ++++++++
 26 files changed, 5156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/tee.txt
 create mode 100644 drivers/tee/Kconfig
 create mode 100644 drivers/tee/Makefile
 create mode 100644 drivers/tee/optee/Kconfig
 create mode 100644 drivers/tee/optee/Makefile
 create mode 100644 drivers/tee/optee/call.c
 create mode 100644 drivers/tee/optee/core.c
 create mode 100644 drivers/tee/optee/optee_msg.h
 create mode 100644 drivers/tee/optee/optee_private.h
 create mode 100644 drivers/tee/optee/optee_smc.h
 create mode 100644 drivers/tee/optee/rpc.c
 create mode 100644 drivers/tee/optee/supp.c
 create mode 100644 drivers/tee/tee_core.c
 create mode 100644 drivers/tee/tee_private.h
 create mode 100644 drivers/tee/tee_shm.c
 create mode 100644 drivers/tee/tee_shm_pool.c
 create mode 100644 include/linux/tee_drv.h
 create mode 100644 include/uapi/linux/tee.h
