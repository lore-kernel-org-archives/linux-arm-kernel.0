From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Sep 2016 15:34:56 +0100
Subject: [PATCH] arm-cci: Fix typo in event name
In-Reply-To: <1472828566-31533-1-git-send-email-suzuki.poulose@arm.com>
References: <1472828566-31533-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160905143456.GD6826@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 04:02:46PM +0100, Suzuki K Poulose wrote:
> Fixes a typo in one of the event name for CCI

Nit: s/name/names/

Coudl you please expand the commit message to something like:

  For one of the CCI events exposed under sysfs, "snoop" was typo'd as
  "snopp". Correct this such that users see the expected event name when
  enumerating events via sysfs.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5755907f..ffa7c9d 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -551,7 +551,7 @@ static struct attribute *cci5xx_pmu_event_attrs[] = {
>  	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_wrq, 0xB),
>  	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_cd_hs, 0xC),
>  	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_rq_stall_addr_hazard, 0xD),
> -	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snopp_rq_stall_tt_full, 0xE),
> +	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_stall_tt_full, 0xE),
>  	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_tzmp1_prot, 0xF),
>  	NULL
>  };
> -- 
> 2.7.4
> 
