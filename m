From: joe@perches.com (Joe Perches)
Date: Wed, 10 Nov 2010 10:24:17 -0800
Subject: [PATCH v3] msm: smd: Reduce driver log chatter
In-Reply-To: <1289411969-24650-1-git-send-email-davidb@codeaurora.org>
References: <1289349036-16941-1-git-send-email-davidb@codeaurora.org>
	<1289411969-24650-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289413457.15905.95.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-10 at 09:59 -0800, David Brown wrote:
>  arch/arm/mach-msm/smd.c |   18 ++++++++++--------

Hi again David.  More trivia. Ignore at your pleasure.

>  1 files changed, 10 insertions(+), 8 deletions(-)
> diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c

A moderately common kernel style uses macros like:

#define FUNC_ENTER()	pr_debug("--> %s\n", __func__);
#define FUNC_EXIT()	pr_debug("<-- %s\n", __func__);
or
#define FUNC_ENTER()	pr_debug("Enter %s\n", __func__);
#define FUNC_EXIT()	pr_debug("Exit  %s\n", __func__);

The macro names vary.
I've seen enter, _enter, kenter, func_enter, etc.

> @@ -939,7 +941,7 @@ int smsm_set_sleep_duration(uint32_t delay)
>  int smd_core_init(void)
>  {
>  	int r;
> -	pr_info("smd_core_init()\n");
> +	pr_debug("smd_core_init()\n");

	FUNC_ENTER();

> @@ -992,14 +994,14 @@ int smd_core_init(void)
>  	smsm_change_state(SMSM_STATE_APPS_DEM, ~0, 0);
>  #endif
>  
> -	pr_info("smd_core_init() done\n");
> +	pr_debug("smd_core_init() done\n");

	FUNC_EXIT();

>  static int __devinit msm_smd_probe(struct platform_device *pdev)
>  {
> -	pr_info("smd_init()\n");
> +	pr_debug("smd_init()\n");

wrong function name? FUNC_ENTER();
