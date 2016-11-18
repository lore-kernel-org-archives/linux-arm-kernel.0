From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 18 Nov 2016 16:45:13 +0200
Subject: [PATCH V8 3/3] stm: Mark the functions of writing buffer with
 notrace
In-Reply-To: <1479438454-28650-4-git-send-email-zhang.chunyan@linaro.org>
References: <1479438454-28650-1-git-send-email-zhang.chunyan@linaro.org>
 <1479438454-28650-4-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <871sy8g83q.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be writen
> to sink via STM, all functions that related to writing data packets to
> STM should be marked 'notrace' to avoid being traced by Ftrace, otherwise
> the program would stall into an endless loop.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c |  2 +-
>  drivers/hwtracing/intel_th/sth.c            | 11 +++++++----
>  drivers/hwtracing/stm/core.c                |  7 ++++---
>  drivers/hwtracing/stm/dummy_stm.c           |  2 +-
>  include/linux/stm.h                         |  4 ++--
>  5 files changed, 15 insertions(+), 11 deletions(-)

Quick nit: can you please split this one in 4: one for Coresight, one
for Intel TH, one for stm/dummy and one for stm/core?

I'd like to keep the bisectability. Otherwise, this is fine by me:

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
