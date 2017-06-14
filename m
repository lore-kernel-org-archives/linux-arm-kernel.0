From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 14 Jun 2017 11:50:42 -0600
Subject: [PATCH 06/12] coresight tmc: Expose DBA and AXICTL
In-Reply-To: <1497278211-5001-7-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170614175042.GB22030@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 03:36:45PM +0100, Suzuki K Poulose wrote:
> Expose DBALO,DBAHI and AXICTL registers

Why is this needed?  I fear we are exposing internal kernel information.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 7025982..fd5a2e0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -228,9 +228,11 @@ coresight_tmc_simple_func(ffcr, TMC_FFCR);
>  coresight_tmc_simple_func(mode, TMC_MODE);
>  coresight_tmc_simple_func(pscr, TMC_PSCR);
>  coresight_tmc_simple_func(devid, CORESIGHT_DEVID);
> +coresight_tmc_simple_func(axictl, TMC_AXICTL);
>  
>  coresight_simple_reg64(struct tmc_drvdata, rrp, TMC_RRP, TMC_RRPHI);
>  coresight_simple_reg64(struct tmc_drvdata, rwp, TMC_RWP, TMC_RWPHI);
> +coresight_simple_reg64(struct tmc_drvdata, dba, TMC_DBALO, TMC_DBAHI);
>  
>  static struct attribute *coresight_tmc_mgmt_attrs[] = {
>  	&dev_attr_rsz.attr,
> @@ -244,6 +246,8 @@ static struct attribute *coresight_tmc_mgmt_attrs[] = {
>  	&dev_attr_mode.attr,
>  	&dev_attr_pscr.attr,
>  	&dev_attr_devid.attr,
> +	&dev_attr_dba.attr,
> +	&dev_attr_axictl.attr,
>  	NULL,
>  };
>  
> -- 
> 2.7.4
> 
