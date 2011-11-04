From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 4 Nov 2011 13:35:07 -0700
Subject: [PATCH v2 4/8] arm/tegra: prepare pinmux code for multiple
	tegra variants
In-Reply-To: <1320242948-21061-5-git-send-email-pdeschrijver@nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4E46@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, November 02, 2011 8:09 AM:
> This patch modifies the pinmux code to be useable for multiple tegra variants.
> Some tegra20 specific constants will be replaced by variables which will be
> initialized to the appropriate value at runtime.
...
> diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
...
> @@ -219,13 +213,20 @@ struct tegra_pingroup_desc {
>  	s8 pupd_bit;	/* offset into the PULL_UPDOWN_REG_* register bit */
>  };
> 
> -extern const struct tegra_pingroup_desc tegra_soc_pingroups[];
> -extern const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[];
> +struct tegra_pinmux_pm {
> +	void (*suspend)(void);
> +	void (*resume)(void);
> +};

You still don't need that struct type.

-- 
nvpublic
