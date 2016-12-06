From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 11:54:57 +0000
Subject: [PATCH 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <1480405463-23165-3-git-send-email-andy.gross@linaro.org>
References: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
 <1480405463-23165-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20161206115456.GC2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 01:44:23AM -0600, Andy Gross wrote:
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
>  drivers/firmware/qcom_scm-64.c | 11 +++++++++--
>  include/linux/arm-smccc.h      | 11 ++++++++---
>  3 files changed, 25 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
