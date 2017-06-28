From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 11:33:46 -0500
Subject: [PATCH v2 01/12] coresight replicator: Cleanup programmable
 replicator naming
In-Reply-To: <1498490576-1350-2-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
 <1498490576-1350-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170628163346.p54iktif4vehvvut@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 04:22:45PM +0100, Suzuki K Poulose wrote:
> The Linux coresight drivers define the programmable ATB replicator as
> Qualcom replicator, while this is designed by ARM. This can cause confusion

Qualcomm

> to a user selecting the driver. Cleanup all references to make it
>  explicitly clear. This patch :
> 
>  1) Replace the compatible string for the replicator :
> 	qcom,coresight-replicator1x => arm,coresight-dynamic-replicator
>  2) Changes the Kconfig symbol (since this is not part of any defconfigs)
> 	 CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
>  3) Improves the help message in the Kconfig.
>  4) Changes the name of the driver and the file :
> 	coresight-replicator-qcom => coresight-dynamic-replicator
> 
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V1:
>  - Since the driver doesn't use the compatible string, change the
>    recommended compatible string.
>  - Rename the driver file to coresight-dynamic-replicator.c
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt            |  4 ++--
>  drivers/hwtracing/coresight/Kconfig                            | 10 +++++-----
>  drivers/hwtracing/coresight/Makefile                           |  2 +-
>  ...esight-replicator-qcom.c => coresight-dynamic-replicator.c} |  5 ++---
>  4 files changed, 10 insertions(+), 11 deletions(-)
>  rename drivers/hwtracing/coresight/{coresight-replicator-qcom.c => coresight-dynamic-replicator.c} (97%)

Acked-by: Rob Herring <robh@kernel.org>
