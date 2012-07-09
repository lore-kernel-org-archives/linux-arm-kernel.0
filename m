From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 9 Jul 2012 16:25:06 +0530
Subject: [PATCH v4 3/5] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1341826026-6504-4-git-send-email-vincent.guittot@linaro.org>
References: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
 <1341826026-6504-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <CAMQu2gydOEVK_fzmzkdrBwBfOq6eZG=0QfLUfFChWJu9unSn2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vincent,
On Mon, Jul 9, 2012 at 2:57 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> Use cpu compatibility field and clock-frequency field of DT to
> estimate the capacity of each core of the system and to update
> the cpu_power field accordingly.
> This patch enables to put more running tasks on big cores than
> on LITTLE ones. But this patch doesn't ensure that long running
> tasks will run on big cores and short ones on LITTLE cores.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/arm/kernel/topology.c |  153 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>
Sorry for not giving this comment on previous version but we should also
have a way to provide the big.LITTLE information without Device Tree.
May be a platform device/data.

I know we are moving DT way, but remember apart from core kernel
infrastructure, to have a complete product build with DT means all the
drivers must be already supporting DT which is not the case with
many huge driver sub-systems like USB, display subsystem, Audio etc.

Having that support would greatly help for the SOC's which have not yet
reached to stage where entire SOC is DT compliant and want to use
big.LITTLE infrastructure.

Regards
Santosh
