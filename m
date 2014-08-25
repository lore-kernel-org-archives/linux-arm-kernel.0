From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Aug 2014 10:24:45 +0200
Subject: [PATCH 01/11 v4] coresight: add CoreSight core layer framework
In-Reply-To: <1408554231-24321-2-git-send-email-mathieu.poirier@linaro.org>
References: <1408554231-24321-1-git-send-email-mathieu.poirier@linaro.org>
 <1408554231-24321-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140825102445.1ff19682@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 20 Aug 2014 11:03:41 -0600, mathieu.poirier at linaro.org wrote:

> diff --git a/drivers/coresight/Makefile b/drivers/coresight/Makefile
> new file mode 100644
> index 0000000..fef87bc
> --- /dev/null
> +++ b/drivers/coresight/Makefile
> @@ -0,0 +1,9 @@
> +#
> +# Makefile for CoreSight drivers.
> +#
> +obj-$(CONFIG_CORESIGHT) += coresight.o
> +obj-$(CONFIG_OF) += of_coresight.o
> +obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-tmc.o coresight-tpiu.o \
> +					   coresight-etb10.o coresight-funnel.o \
> +					   coresight-replicator.o
> +obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o

I believe this is a bit messed up with PATCH 02/11. Here you're adding
references to many files that aren't part of this patch, but are added
in subsequent patches. PATCH 02/11 removes those lines and replaces
them by the correct values. Surely an interactive rebase conflict that
was not solved properly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
