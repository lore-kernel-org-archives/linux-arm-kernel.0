From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 13 Jul 2016 14:40:59 +0300
Subject: [PATCH RESEND 2/2] perf tools: adding coresight etm PMU record
 capabilities
In-Reply-To: <1466182922-14426-3-git-send-email-mathieu.poirier@linaro.org>
References: <1466182922-14426-1-git-send-email-mathieu.poirier@linaro.org>
 <1466182922-14426-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <578628CB.8020707@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/16 20:02, Mathieu Poirier wrote:
> Coresight ETMs are IP blocks used to perform HW assisted tracing
> on a CPU core.  This patch introduce the required auxiliary API
> functions allowing the perf core to interact with a tracer.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  MAINTAINERS                         |   3 +
>  tools/perf/arch/arm/util/Build      |   2 +-
>  tools/perf/arch/arm/util/auxtrace.c |  54 ++++
>  tools/perf/arch/arm/util/cs-etm.c   | 559 ++++++++++++++++++++++++++++++++++++
>  tools/perf/arch/arm/util/cs-etm.h   |  23 ++
>  tools/perf/arch/arm64/util/Build    |   4 +
>  tools/perf/util/auxtrace.c          |   1 +
>  tools/perf/util/auxtrace.h          |   1 +
>  tools/perf/util/cs-etm.h            |  74 +++++
>  9 files changed, 720 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/arm/util/auxtrace.c
>  create mode 100644 tools/perf/arch/arm/util/cs-etm.c
>  create mode 100644 tools/perf/arch/arm/util/cs-etm.h
>  create mode 100644 tools/perf/util/cs-etm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3451007718b..4fa03b03bfc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1086,6 +1086,9 @@ F:	Documentation/trace/coresight.txt
>  F:	Documentation/devicetree/bindings/arm/coresight.txt
>  F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>  F:	tools/perf/arch/arm/util/pmu.c
> +F:	tools/perf/arch/arm/util/auxtrace.c
> +F:	tools/perf/arch/arm/util/cs_etm.c
> +F:	tools/perf/arch/arm/util/cs_etm.h

File names have changed from having '_' to '-'
Also FWIW there is now tools/perf/util/cs-etm.h

As last time, there is no decoder, which still begs the question: is there
anything you can actually do with the perf.data file?

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
