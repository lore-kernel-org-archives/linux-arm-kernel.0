From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 23 Apr 2015 11:17:32 -0400
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <55390D0C.7000405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2015 06:40 PM, Mathieu Poirier wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> This driver manages the CoreSight ETMv4 (Embedded Trace Macrocell) IP block
> to support HW assisted tracing on ARMv7 and ARMv8 architectures.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  28 +
>  drivers/hwtracing/coresight/Kconfig                |  10 +
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 833 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 391 ++++++++++
>  5 files changed, 1263 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> new file mode 100644
> index 000000000000..a4b623871ca0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> @@ -0,0 +1,28 @@
> +What:		/sys/bus/coresight/devices/<memory_map>.etm/enable_source
> +Date:		April 2015
> +KernelVersion:  4.01
> +Contact:        Mathieu Poirier <mathieu.poirier@linaro.org>
> +Description:	(RW) Enable/disable tracing on this specific trace entiry.
                                                                   ^
                                                                   entry

> +		Enabling a source implies the source has been configured
> +		properly and a sink has been identidifed for it.  The path
                                             ^
                                             identified
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
