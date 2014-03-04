From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 4 Mar 2014 11:59:34 -0600
Subject: [PATCH 2/3] soc: keystone: add QMSS driver
In-Reply-To: <1393629520-12713-3-git-send-email-santosh.shilimkar@ti.com>
References: <1393629520-12713-1-git-send-email-santosh.shilimkar@ti.com>
 <1393629520-12713-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AAE2808F-A2C8-4031-BFA4-1A20B182EA69@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 28, 2014, at 5:18 PM, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> From: Sandeep Nair <sandeep_n@ti.com>
> 
> The QMSS (Queue Manager Sub System) found on Keystone SOCs is one of
> the main hardware sub system which forms the backbone of the Keystone
> Multi-core Navigator. QMSS consist of queue managers, packed-data structure
> processors(PDSP), linking RAM, descriptor pools and infrastructure
> Packet DMA.
> 
> The Queue Manager is a hardware module that is responsible for accelerating
> management of the packet queues. Packets are queued/de-queued by writing or
> reading descriptor address to a particular memory mapped location. The PDSPs
> perform QMSS related functions like accumulation, QoS, or event management.
> Linking RAM registers are used to link the descriptors which are stored in
> descriptor RAM. Descriptor RAM is configurable as internal or external memory.
> 
> The QMSS driver manages the PDSP setups, linking RAM regions,
> queue pool management (allocation, push, pop and notify) and descriptor
> pool management. The specifics on the device tree bindings for
> QMSS can be found in:
>        Documentation/devicetree/bindings/soc/keystone-qmss.txt
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sandeep Nair <sandeep_n@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> .../devicetree/bindings/soc/keystone-qmss.txt      |  209 +++
> drivers/Kconfig                                    |    2 +
> drivers/Makefile                                   |    3 +
> drivers/soc/Kconfig                                |    2 +
> drivers/soc/Makefile                               |    5 +
> drivers/soc/keystone/Kconfig                       |   15 +
> drivers/soc/keystone/Makefile                      |    5 +
> drivers/soc/keystone/qmss_acc.c                    |  591 ++++++++
> drivers/soc/keystone/qmss_queue.c                  | 1533 ++++++++++++++++++++
> drivers/soc/keystone/qmss_queue.h                  |  236 +++
> include/linux/soc/keystone_qmss.h                  |  390 +++++
> 11 files changed, 2991 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/soc/keystone-qmss.txt
> create mode 100644 drivers/soc/Makefile
> create mode 100644 drivers/soc/keystone/Kconfig
> create mode 100644 drivers/soc/keystone/Makefile
> create mode 100644 drivers/soc/keystone/qmss_acc.c
> create mode 100644 drivers/soc/keystone/qmss_queue.c
> create mode 100644 drivers/soc/keystone/qmss_queue.h
> create mode 100644 include/linux/soc/keystone_qmss.h

Do you see qmss being able to provide HW support for a qdisc or doing processor to processor communication over something like rpmsg?

I ask because I do wondering if we should be looking at a drivers/hwqueue as other vendors have similar hardware.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
