From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 17 Jun 2016 12:26:06 -0400
Subject: [RFC PATCH 4/4] stm: Mark the functions of writing buffer with
 notrace
In-Reply-To: <1464779939-24986-5-git-send-email-zhang.chunyan@linaro.org>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
 <1464779939-24986-5-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20160617122606.417cf5a0@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Jun 2016 19:18:59 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> If CONFIG_STM_FTRACE is selected, Function trace data would be
> writen to STM buffer, all  functions that related to writing data
> packets to STM buffer should be marked 'notrace' to avoid being
> traced by Ftrace, otherwise the program would stall into an endless loop.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c |  2 +-
>  drivers/hwtracing/intel_th/sth.c            | 11 +++++++----
>  drivers/hwtracing/stm/core.c                |  7 ++++---
>  drivers/hwtracing/stm/dummy_stm.c           |  2 +-
>  include/linux/stm.h                         |  4 ++--
>  5 files changed, 15 insertions(+), 11 deletions(-)

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
