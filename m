From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Sep 2017 14:49:16 +0100
Subject: [v4 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
In-Reply-To: <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170914134916.evw2mhjhxa6zo72x@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 04:37:49PM -0400, Roy Pledge wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Not relevant and arch dependent. Overkill for PPC.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
> index 2ce394a..f85c319 100644
> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
> @@ -49,10 +49,6 @@
>  #define DPAA_PORTAL_CE 0
>  #define DPAA_PORTAL_CI 1
>  
> -#if (L1_CACHE_BYTES != 32) && (L1_CACHE_BYTES != 64)
> -#error "Unsupported Cacheline Size"
> -#endif

Maybe this check was for a reason on PPC as it uses WB memory mappings
for some of the qbman descriptors (which IIUC fit within a cacheline).
You could add a check for CONFIG_PPC if you think there is any chance of
this constant going higher.

-- 
Catalin
