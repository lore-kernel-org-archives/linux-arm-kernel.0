From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 10:10:15 +0100
Subject: [PATCH V4 13/18] coresight: tmc: make sysFS and Perf mode
 mutually exclusive
In-Reply-To: <1461708634-6327-14-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-14-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <572081F7.9060709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> The sysFS and Perf access methods can't be allowed to interfere
> with one another.  As such introducing guards to access
> functions that prevents moving forward if a TMC is already
> being used.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 60 +++++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 62 +++++++++++++++++++++++--
>   2 files changed, 117 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index b5e5e6ac67eb..b11c52be54a9 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
