From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:01:06 -0600
Subject: [PATCH v5 2/5] ARM: tegra: move fuse exports to tegra-soc.h
In-Reply-To: <1401281677-32110-3-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <1401281677-32110-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <538783F2.9020901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> All fuse related functionality will move to a driver in the following patches.
> To prepare for this, export all the required functionality in a global header
> file and move all users of fuse.h to tegra-soc.h. While we're at it, remove
> tegra_bct_strapping, as its only user was removed in Commit a7cbe92cef27
> ("ARM: tegra: remove tegra EMC scaling driver").

> diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h

> @@ -33,4 +54,8 @@ static inline int tegra_apb_writel_using_dma(u32 value, unsigned long offset)
>  	return -EINVAL;
>  }
>  #endif
> +
> +#endif /* __ASSEMBLY__ */
> +
> +
>  #endif /* __LINUX_TEGRA_SOC_H_ */

Nit: 2 blank lines there. I'll try and remember to fix that up when I
apply this, if nothing requires a repost.
