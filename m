From: oss@buserror.net (Scott Wood)
Date: Sat, 15 Sep 2018 14:24:21 -0500
Subject: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
In-Reply-To: <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
 <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-09-14 at 02:07 +0530, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3a1812f..e9ae70b 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -79,7 +79,7 @@ struct clockgen_chipinfo {
>  	const struct clockgen_muxinfo *cmux_groups[2];
>  	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
>  	void (*init_periph)(struct clockgen *cg);
> -	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than
> NUM_CMUX */
> +	int cmux_to_group[NUM_CMUX+1]; /* -1 terminate if fewer to
> NUM_CMUX+1 */

You need to add the -1 terminator to p4080, and remove the "if fewer" comment
since the whole point of this is that every array gets -1 terminated.

Why did you change "terminates" to "terminate" and "than" to "to"?

This +1 change should be a separate patch from lx2160a support.

-Scott
