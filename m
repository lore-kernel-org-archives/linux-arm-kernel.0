From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 19 Sep 2012 18:02:51 +0200
Subject: [PATCH 3/4] mfd: dbx500: Provide a more accurate smp_twd clock
In-Reply-To: <1346415691-13371-4-git-send-email-ulf.hansson@stericsson.com>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
 <1346415691-13371-4-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20120919160251.GM28670@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, Aug 31, 2012 at 02:21:30PM +0200, Ulf Hansson wrote:
> From: Michel Jaouen <michel.jaouen@stericsson.com>
> 
> The local timer clock is based on ARM subsystem clock. This patch
> obtains a more exact value of that clock by reading PRCMU registers.
> Using this increases the accuracy of the local timer events.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
> Signed-off-by: Michel Jaouen <michel.jaouen@stericsson.com>
> ---
>  drivers/mfd/db8500-prcmu.c       |   42 ++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/dbx500-prcmu-regs.h  |    4 +++-
>  include/linux/mfd/dbx500-prcmu.h |    1 +
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 4f74529..e7f9539 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -418,6 +418,9 @@ static struct {
>  
>  static atomic_t ac_wake_req_state = ATOMIC_INIT(0);
>  
> +/* Functions definition */
> +static void compute_armss_rate(void);
> +
I'm not a big fan of forward declarations, but I still applied your patch to
my for-next branch. Thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
