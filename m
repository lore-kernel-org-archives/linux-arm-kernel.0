From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 22 Aug 2016 18:15:56 +0300
Subject: [PATCH V5 0/9] perf: Driver specific configuration for PMU
In-Reply-To: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <878tvon8b7.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> As such something that used to be a two-step process:
>
> # echo 1 > /sys/bus/coresight/devices/20070000.etr/enable_sink
> # perf record -e cs_etm//u --per-thread  uname
>
> is integrated in a single command:
>
> # perf record -e cs_etm/@sink=20070000.etr/u --per-thread  uname

Can't we simply teach perf record to write 1 to that sysfs attribute and
avoid parsing more ascii strings in the kernel? I suspect that would also
take way less code.

Are there any other use cases for this besides specifying @sink for a
ETM?

Regards,
--
Alex
