From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 23 Apr 2015 11:08:53 -0400
Subject: [PATCH 10/11] coresight-etm4x: Controls pertaining to the
 context ID functions
In-Reply-To: <1429742451-11465-11-git-send-email-mathieu.poirier@linaro.org>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-11-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <55390B05.1050801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 04/22/2015 06:40 PM, Mathieu Poirier wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> Adding sysfs entries to access and configure specifics about the
> context ID comparator functions.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  19 +++
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 187 +++++++++++++++++++++
>  2 files changed, 206 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> index b5c0456290ab..8b32cb7b9723 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> @@ -254,3 +254,22 @@ Date:		April 2015
>  KernelVersion:	4.01
>  Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description: 	(RW) Controls the selection of the resources in the trace unit.
> +
> +What:		/sys/bus/coresight/devices/<memory_map>.etm/ctxid_idx
> +Date:		April 2015
> +KernelVersion:	4.01
> +Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +Description:	(RW) Select which context ID comparator to work with.
> +
> +What:		/sys/bus/coresight/devices/<memory_map>.etm/ctxid_val
> +Date:		April 2015
> +KernelVersion:	4.01
> +Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +Description:	(RW) Get/Set the context ID comparator value to trigger on.

If I'm understanding this correctly, ctxid_val is multiplexed using ctxid_idx.
Why not just have ctxid_val0, ctxid_val1, ...?

Thanks,
Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
