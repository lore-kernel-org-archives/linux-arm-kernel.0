From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 17:33:46 +0000
Subject: [Patch v2 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <1483054046-3327-3-git-send-email-andy.gross@linaro.org>
References: <1483054046-3327-1-git-send-email-andy.gross@linaro.org>
 <1483054046-3327-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20170104173346.GN18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 05:27:26PM -0600, Andy Gross wrote:
> This patch adds a Qualcomm specific quirk to the arm_smccc_smc call.
> 
> On Qualcomm ARM64 platforms, the SMC call can return before it has
> completed.  If this occurs, the call can be restarted, but it requires
> using the returned session ID value from the interrupted SMC call.
> 
> The quirk stores off the session ID from the interrupted call in the
> quirk structure so that it can be used by the caller.
> 
> This patch folds in a fix given by Sricharan R:
> https://lkml.org/lkml/2016/9/28/272
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm64/kernel/smccc-call.S |  9 ++++++++-
>  drivers/firmware/qcom_scm-64.c | 13 ++++++++++---
>  include/linux/arm-smccc.h      | 11 ++++++++---
>  3 files changed, 26 insertions(+), 7 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks for sticking with this, it looks good to me now.

Will
