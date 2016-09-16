From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 16 Sep 2016 15:49:01 +0300
Subject: [PATCH V6 0/3] Adding support for address filters
In-Reply-To: <1473957428-28311-1-git-send-email-mathieu.poirier@linaro.org>
References: <1473957428-28311-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <ffb32202-50c4-50fc-0f75-01a109bfac72@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/16 19:37, Mathieu Poirier wrote:
> This patch set makes it possible to use the current filter
> framework with address filters.  That way address filters for
> HW tracers such as CoreSight and IntelPT can be communicated
> to the kernel drivers.

FYI, I am working on patches to add support for entering address filters
using symbol names.  I will probably send them next week.

> 
> In this revision precursor work is done to make function
> perf_evsel__append_filter() generic, along with changes to
> current customers.  From there the work on address filters is
> introduced.
> 
> Thanks,
> Mathieu
> 
> ---
> Changes for V6:
>  - Split work in 3 (small) patches.
>  - Adding tracepoint and address filter append() functions
> 
> Changes for V5:
>  - Modified perf_evsel__append_filter() to take a string format
>    rather than an operation.
> 
> Changes for V4:
>  - Added support for address filters over more than one
>    nibble.
>  - Removed Jiri's ack, this version is too different from
>    what was reviewed.
> 
> Changes for V3:
>  - Added Jiri's ack.
>  - Rebased to v4.8-rc5.
> 
> Changes for V2:
>  - Rebased to v4.8-rc4.
>  - Revisited error path.
> 
> Mathieu Poirier (3):
>   perf tools: making perf_evsel__append_filter() generic
>   perf tools: new tracepoint specific function
>   perf tools: adding support for address filters
> 
>  tools/perf/builtin-trace.c     |  8 ++++++--
>  tools/perf/util/evsel.c        | 16 +++++++++++++---
>  tools/perf/util/evsel.h        |  5 +++--
>  tools/perf/util/parse-events.c | 41 +++++++++++++++++++++++++++++++++++------
>  4 files changed, 57 insertions(+), 13 deletions(-)
> 
