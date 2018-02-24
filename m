From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 23 Feb 2018 16:56:37 -0800
Subject: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
In-Reply-To: <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
Message-ID: <5A90B845.3030504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 04:19 PM, Saravana Kannan wrote:
> Some PMUs events can be read from any CPU. So allow the PMU to mark
> events as such. For these events, we don't need to reject reads or
> make smp calls to the event's CPU and cause unnecessary wake ups.
>
> Good examples of such events would be events from caches shared across
> all CPUs.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>   include/linux/perf_event.h |  3 +++
>   kernel/events/core.c       | 10 ++++++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
>

Ugh! Didn't mean to chain these two emails. This one is independent of 
the other email.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
