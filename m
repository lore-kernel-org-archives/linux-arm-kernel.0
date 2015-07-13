From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 13 Jul 2015 11:26:11 -0600
Subject: [PATCH 0/5] coresight: Support context-ID tracing when PID
 namespace is enabled
In-Reply-To: <1436258518-9339-1-git-send-email-zhang.chunyan@linaro.org>
References: <1436258518-9339-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <CANLsYkwBmquLNiDfUXzZmwEDR7Ow2CPPCoiUrSQKgXTnoN0ohg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2015 at 02:41, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> The Coresight ETM drivers already support context-ID tracing, but it won't
> work when PID namespace is enabled. This is because when using PID
> namespace a process id (ie. VPID) seen from the current namespace differs
> from the id (ie. PID) seen by kernel.
>
> This patch-set does add a translation between VPID and PID.
>
> Chunyan Zhang (5):
>   coresight-etm3x: Change the name of the ctxid_val to ctxid_pid
>   coresight-etm4x: Change the name of the ctxid_val to ctxid_pid
>   Coresight: Add an interface for supporting ETM3/4 Context ID tracing
>   coresight-etm3x: Support context-ID tracing when PID namespace is
>     enabled
>   coresight-etm4x: Support context-ID tracing when PID namespace is
>     enabled
>
>  .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |  2 +-
>  .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  2 +-
>  drivers/hwtracing/coresight/coresight-etm.h        |  7 ++--
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 28 +++++++++-------
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 37 ++++++++++++++--------
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  7 ++--
>  include/linux/coresight.h                          | 20 ++++++++++++
>  7 files changed, 72 insertions(+), 31 deletions(-)
>
> --
> 1.9.1
>

Applied - thanks.
