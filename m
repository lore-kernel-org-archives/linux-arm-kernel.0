From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Jan 2016 07:31:24 +0000
Subject: [PATCH v5 0/7] remoteproc: Add driver for STMicroelectronics
 platforms
In-Reply-To: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160127073124.GI3368@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies for ping (I hate doing that), but I haven't heard anything
from you.  Do you want me to re-submit this set, or are you willing to
take this and apply the relevant Acks?

> ST's platforms often have multiple co-processors (usually ST40s or ST231s)
> on-board.  This provides the Linux-side infrastructure to flash and boot
> them successfully.
>   
> This set has been tested on an STiH410-B2120.
> 
> v4 => v5:
>  - Check for invalid 'count' (command read length) in write fn()s
>   
> v3 => v4:
>  Suggested-by: Suman Anna <s-anna@ti.com>
>  - Move to using 'reserved-memory' API
>    - New 'reserved-memory' nodes
>    - Remove memory locations from RemoteProc's DT node's reg properties
>    - Remove C code obtaining/allocating DMA memory
>  - Re-order .start() and .stop() ops
>  - Add protection around Reset API in error path
>  - Explicitly set .has_iommu to false
>   
> v2 => v3:
>  - Generify syscon property (st,syscfg-boot => st,syscfg)
>  - Rename IP in DT bindings doc (Remote Processor => Co-Processor)
>  - Remove superfluous 'clock-names' property
>  - Remove superfluous 'reg-names' property
>  - Populate MAINTAINERS
>  - Clean-up DTS formatting
>  - Use strings in debugfs to control procs ('1|0' => 'start|stop')
>  - Align copyright statement with MODULE() macros
>  - Rename driver data structure ('st_rproc' => 'ddata')
>  - Addition of a full error path in .start()
> 
> v1 => v2:
>  - Remove Linux implementation specific comment from binding document
>  - Force debugfs '0' to shutdown co-processor - rather than !1
>  - Supply more detailed commit message
>  - Propagate errors back from .stop()
>  - Review GPL wording
>  - Supply original author's SoBs
> 
> Lee Jones (7):
>   remoteproc: debugfs: Check of invalid 'count' value
>   remoteproc: dt: Provide bindings for ST's Remote Processor Controller
>     driver
>   remoteproc: debugfs: Add ability to boot remote processor using
>     debugfs
>   remoteproc: Supply controller driver for ST's Remote Processors
>   MAINTAINERS: Add ST's Remote Processor Driver to ARM/STI ARCHITECTURE
>   ARM: STiH407: Add nodes for RemoteProc
>   ARM: STiH407: Move over to using the 'reserved-memory' API for
>     obtaining DMA memory
> 
>  .../devicetree/bindings/remoteproc/st-rproc.txt    |  41 +++
>  MAINTAINERS                                        |   1 +
>  arch/arm/boot/dts/stih407-family.dtsi              |  70 +++++
>  drivers/remoteproc/Kconfig                         |   9 +
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/remoteproc_debugfs.c            |  38 ++-
>  drivers/remoteproc/st_remoteproc.c                 | 297 +++++++++++++++++++++
>  7 files changed, 455 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
>  create mode 100644 drivers/remoteproc/st_remoteproc.c
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
