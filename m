From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Mar 2015 23:27:41 +0100
Subject: [PATCH] coresight: moving to new "hwtracing" directory
In-Reply-To: <1426802522-25743-1-git-send-email-mathieu.poirier@linaro.org>
References: <1426802522-25743-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150319222741.GA24999@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 04:02:02PM -0600, Mathieu Poirier wrote:
> Keeping drivers related to HW tracing on ARM, i.e coresight,
> under "drivers/coresight" doesn't make sense when other
> architectures start rolling out technologies of the same
> nature.
> 
> As such creating a new "drivers/hwtracing" directory where all
> drivers of the same kind can reside, reducing namespace
> pollution under "drivers/".
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  MAINTAINERS                                        |    2 +-
>  arch/arm/Kconfig.debug                             |    2 +-
>  arch/arm64/Kconfig.debug                           |    2 +-
>  drivers/Makefile                                   |    2 +-
>  drivers/coresight/Kconfig                          |   61 -
>  drivers/coresight/Makefile                         |   11 -
>  drivers/coresight/coresight-etb10.c                |  527 ------
>  drivers/coresight/coresight-etm-cp14.c             |  591 ------
>  drivers/coresight/coresight-etm.h                  |  251 ---
>  drivers/coresight/coresight-etm3x.c                | 1932 --------------------
>  drivers/coresight/coresight-funnel.c               |  258 ---
>  drivers/coresight/coresight-priv.h                 |   63 -
>  drivers/coresight/coresight-replicator.c           |  137 --
>  drivers/coresight/coresight-tmc.c                  |  822 ---------
>  drivers/coresight/coresight-tpiu.c                 |  207 ---
>  drivers/coresight/coresight.c                      |  720 --------
>  drivers/coresight/of_coresight.c                   |  200 --
>  drivers/hwtracing/coresight/Kconfig                |   61 +
>  drivers/hwtracing/coresight/Makefile               |   11 +
>  drivers/hwtracing/coresight/coresight-etb10.c      |  527 ++++++
>  drivers/hwtracing/coresight/coresight-etm-cp14.c   |  591 ++++++
>  drivers/hwtracing/coresight/coresight-etm.h        |  251 +++
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 1932 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-funnel.c     |  258 +++
>  drivers/hwtracing/coresight/coresight-priv.h       |   63 +
>  drivers/hwtracing/coresight/coresight-replicator.c |  137 ++
>  drivers/hwtracing/coresight/coresight-tmc.c        |  822 +++++++++
>  drivers/hwtracing/coresight/coresight-tpiu.c       |  207 +++
>  drivers/hwtracing/coresight/coresight.c            |  720 ++++++++
>  drivers/hwtracing/coresight/of_coresight.c         |  200 ++
>  30 files changed, 5784 insertions(+), 5784 deletions(-)
>  delete mode 100644 drivers/coresight/Kconfig
>  delete mode 100644 drivers/coresight/Makefile
>  delete mode 100644 drivers/coresight/coresight-etb10.c
>  delete mode 100644 drivers/coresight/coresight-etm-cp14.c
>  delete mode 100644 drivers/coresight/coresight-etm.h
>  delete mode 100644 drivers/coresight/coresight-etm3x.c
>  delete mode 100644 drivers/coresight/coresight-funnel.c
>  delete mode 100644 drivers/coresight/coresight-priv.h
>  delete mode 100644 drivers/coresight/coresight-replicator.c
>  delete mode 100644 drivers/coresight/coresight-tmc.c
>  delete mode 100644 drivers/coresight/coresight-tpiu.c
>  delete mode 100644 drivers/coresight/coresight.c
>  delete mode 100644 drivers/coresight/of_coresight.c
>  create mode 100644 drivers/hwtracing/coresight/Kconfig
>  create mode 100644 drivers/hwtracing/coresight/Makefile
>  create mode 100644 drivers/hwtracing/coresight/coresight-etb10.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm-cp14.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm3x.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-funnel.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-priv.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-replicator.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-tmc.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-tpiu.c
>  create mode 100644 drivers/hwtracing/coresight/coresight.c
>  create mode 100644 drivers/hwtracing/coresight/of_coresight.c

This looks good to me, but please create your patches with -M option to
git, so it just moves the code, and we can easily see that it is a move
and nothing else changed.

thanks,

greg k-h
