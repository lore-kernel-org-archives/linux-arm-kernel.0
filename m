From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed, 18 Apr 2018 14:19:50 -0300
Subject: [PATCH] perf tools: coresight: Moving to SPDX identifier
In-Reply-To: <1523912013-29331-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523912013-29331-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180418171950.GA22762@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Apr 16, 2018 at 02:53:33PM -0600, Mathieu Poirier escreveu:
> Moving perf tools CoreSight support to the SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h             | 13 +------------
>  tools/perf/arch/arm/util/auxtrace.c             | 13 +------------
>  tools/perf/arch/arm/util/cs-etm.c               | 13 +------------
>  tools/perf/arch/arm/util/cs-etm.h               | 13 +------------
>  tools/perf/arch/arm/util/pmu.c                  | 13 +------------
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  3 +--
>  tools/perf/util/cs-etm.c                        |  3 +--
>  tools/perf/util/cs-etm.h                        | 13 +------------
>  8 files changed, 8 insertions(+), 76 deletions(-)

So now I get:

[acme at jouet perf]$ make -C tools/perf
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
  INSTALL  GTK UI
  INSTALL  trace_plugin
<SNIP>

You should either send the patch to both files or first send it to the
kernel, then to tools/, I just checked and this SPDX using
coresight-pmu.h file hasn't hit upstream, so we're in the future here,
i.e. tools/include has a _copy_ of what is in include/ :-)

I'm dropping this patch from my tree till this gets resolved.

- Arnaldo
