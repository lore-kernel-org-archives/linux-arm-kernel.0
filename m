From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 4 Aug 2016 18:58:21 +0200
Subject: [PATCH V3 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160804165821.GT6862@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 03:42:18PM -0600, Mathieu Poirier wrote:
> This patch somewhat mimics the work done on address filters to
> add the infrastructure needed to pass PMU specific HW
> configuration to the driver before a session starts.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index c66a485a24ac..90fbc5fd3925 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -407,6 +407,7 @@ struct perf_event_attr {
>  #define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
>  #define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT	_IOW('$', 9, __u32)
> +#define PERF_EVENT_IOC_SET_DRV_CONFIGS	_IOW('$', 10, char *)

Please also do a manpages patch.
