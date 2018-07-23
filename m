From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Mon, 23 Jul 2018 09:35:07 +0800
Subject: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20180723013507.GA27713@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Wed, Jul 11, 2018 at 03:45:39PM +0800, Leo Yan wrote:

Just want to confirm, I saw the first two patches in this serise have
been merged into perf/core branch [1], but the last 4 patches are
missed.

Could I know if you have trouble when you apply them?  Or anything
need me to follow up?  Otherwise you might miss them :)

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

> Leo Yan (6):
>   perf cs-etm: Introduce invalid address macro
>   perf cs-etm: Bail out immediately for instruction sample failure
>   perf cs-etm: Fix start tracing packet handling
>   perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
>   perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
>     packet
>   perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> 
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
>  3 files changed, 68 insertions(+), 14 deletions(-)
> 
> -- 
> 2.7.4
> 
