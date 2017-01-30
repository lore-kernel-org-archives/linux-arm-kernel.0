From: nleeder@codeaurora.org (Leeder, Neil)
Date: Sun, 29 Jan 2017 22:16:36 -0500
Subject: [PATCH v8] perf: add qcom l2 cache perf events driver
In-Reply-To: <1484592767-23687-1-git-send-email-nleeder@codeaurora.org>
References: <1484592767-23687-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <814d6b09-33db-9460-0eba-e2602989532c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone had a chance to look at this yet - I'd appreciate any comments.

Thanks,
Neil

On 1/16/2017 1:52 PM, Neil Leeder wrote:
> Adds perf events support for L2 cache PMU.
>
> The L2 cache PMU driver is named 'l2cache_0' and can be used
> with perf events to profile L2 events such as cache hits
> and misses on Qualcomm Technologies processors.
>
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
> v8:
> Various style changes for function names & code restructuring
> Replace dev_warn with ratelimited debug prints
> Move hotplug registration before PMU registration
> Reload counters with a fixed value
> Add column-exclusion check for events in same group
> Rebase on 4.10-rc3
