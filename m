From: robert.marklund@stericsson.com (Robert MARKLUND)
Date: Thu, 21 Feb 2013 15:32:38 +0100
Subject: CoreSight framework and drivers
In-Reply-To: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE73272F65EE59@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Would it be easy to add dummy sources to control data coming from other ETM sources not controlled by the kernel.
Also I want the ability to have multiple sinks enabled at one time and just control the flow from the sources to direct where the data goes.
Not that clear but I hope you understand :)

BR
Robert

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> pratikp at codeaurora.org
> Sent: den 18 december 2012 20:19
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux at arm.linux.org.uk; linus.walleij at linaro.org; will.deacon at arm.com; Magnus PERSSON; david.rusling at linaro.org;
> arve at android.com; dsaxena at linaro.org; john.stultz at linaro.org; jon-hunter at ti.com; d-deao at ti.com; Christian BEJRAM; devicetree-
> discuss at lists.ozlabs.org
> Subject: CoreSight framework and drivers
> 
> This RFC is aimed at introducing CoreSight framework as well as
> individual CoreSight trace component drivers adhering to ARM
> CoreSight specification. Some prior discussion on this can be
> referred at [1].
> 
> There are 3 kinds of CoreSight trace components:
> 
> * Sources: Responsible for producing trace data to provide
>   visibility for the associated entity.
> 
> * Links: Transport components that carry trace data.
> 
> * Sinks: Collectors for storing trace data or acting as conduits
>   for off-chip trace data collection.
> 
> These components can be connected in various topologies to suite
> a particular SoCs tracing needs.
> 
> Framework is responsible for gathering and using the information
> about the registered CoreSight components and their connections
> to allow it to dynamically deduce the sequence of components
> representing a connection from a CoreSight source to the
> currently selected CoreSight sink. This helps the framework to
> program the correct set of components to satisfy user request.
> 
> [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/204591
> 
> Pratik Patel (8):
>   coresight: add CoreSight core layer framework
>   coresight: add CoreSight TMC driver
>   coresight: add CoreSight TPIU driver
>   coresight: add CoreSight ETB driver
>   coresight: add CoreSight Funnel driver
>   coresight: add CoreSight Replicator driver
>   coresight: add CoreSight STM driver
>   coresight: add CoreSight ETM driver
> 
>  Documentation/devicetree/bindings/arm/coresight.txt |  110 ++
>  arch/arm/include/asm/hardware/cp14.h                |  540 ++++++
>  drivers/Kconfig                                     |    2 +
>  drivers/Makefile                                    |    1 +
>  drivers/coresight/Kconfig                           |   60 +
>  drivers/coresight/Makefile                          |    8 +
>  drivers/coresight/coresight-etb.c                   |  467 +++++
>  drivers/coresight/coresight-etm-cp14.c              |  510 ++++++
>  drivers/coresight/coresight-etm.c                   | 1752 +++++++++++++++++++
>  drivers/coresight/coresight-funnel.c                |  260 +++
>  drivers/coresight/coresight-priv.h                  |   48 +
>  drivers/coresight/coresight-replicator.c            |  211 +++
>  drivers/coresight/coresight-stm.c                   |  819 +++++++++
>  drivers/coresight/coresight-tmc.c                   |  794 +++++++++
>  drivers/coresight/coresight-tpiu.c                  |  232 +++
>  drivers/coresight/coresight.c                       |  681 +++++++
>  drivers/coresight/of_coresight.c                    |   99 ++
>  include/linux/coresight-stm.h                       |   51 +
>  include/linux/coresight.h                           |  167 ++
>  include/linux/of_coresight.h                        |   27 +
>  20 files changed, 6839 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
>  create mode 100644 arch/arm/include/asm/hardware/cp14.h
>  create mode 100644 drivers/coresight/Kconfig
>  create mode 100644 drivers/coresight/Makefile
>  create mode 100644 drivers/coresight/coresight-etb.c
>  create mode 100644 drivers/coresight/coresight-etm-cp14.c
>  create mode 100644 drivers/coresight/coresight-etm.c
>  create mode 100644 drivers/coresight/coresight-funnel.c
>  create mode 100644 drivers/coresight/coresight-priv.h
>  create mode 100644 drivers/coresight/coresight-replicator.c
>  create mode 100644 drivers/coresight/coresight-stm.c
>  create mode 100644 drivers/coresight/coresight-tmc.c
>  create mode 100644 drivers/coresight/coresight-tpiu.c
>  create mode 100644 drivers/coresight/coresight.c
>  create mode 100644 drivers/coresight/of_coresight.c
>  create mode 100644 include/linux/coresight-stm.h
>  create mode 100644 include/linux/coresight.h
>  create mode 100644 include/linux/of_coresight.h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
