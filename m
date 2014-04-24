From: balbi@ti.com (Felipe Balbi)
Date: Wed, 23 Apr 2014 20:30:53 -0500
Subject: [PATCH v2 4/6] soc: ti: add Keystone Navigator QMSS driver
In-Reply-To: <1398296783-1176-5-git-send-email-santosh.shilimkar@ti.com>
References: <1398296783-1176-1-git-send-email-santosh.shilimkar@ti.com>
 <1398296783-1176-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140424013053.GC13374@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 23, 2014 at 07:46:20PM -0400, Santosh Shilimkar wrote:
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
> 	Documentation/devicetree/bindings/soc/keystone-navigator-qmss.txt
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
>  drivers/Kconfig                  |    2 +
>  drivers/soc/Kconfig              |    2 +
>  drivers/soc/Makefile             |    5 +
>  drivers/soc/ti/Kconfig           |   21 +
>  drivers/soc/ti/Makefile          |    4 +
>  drivers/soc/ti/knav_qmss.h       |  386 ++++++++
>  drivers/soc/ti/knav_qmss_acc.c   |  591 +++++++++++++
>  drivers/soc/ti/knav_qmss_queue.c | 1814 ++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/ti/knav_qmss.h |   90 ++
>  9 files changed, 2915 insertions(+)
>  create mode 100644 drivers/soc/Makefile
>  create mode 100644 drivers/soc/ti/Kconfig
>  create mode 100644 drivers/soc/ti/Makefile
>  create mode 100644 drivers/soc/ti/knav_qmss.h
>  create mode 100644 drivers/soc/ti/knav_qmss_acc.c
>  create mode 100644 drivers/soc/ti/knav_qmss_queue.c
>  create mode 100644 include/linux/soc/ti/knav_qmss.h
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 0e87a34..8993913 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -148,6 +148,8 @@ source "drivers/remoteproc/Kconfig"
>  
>  source "drivers/rpmsg/Kconfig"
>  
> +source "drivers/soc/Kconfig"

This hunk was already in patch one but in a different offset in this
file.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/84c79025/attachment-0001.sig>
