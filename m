From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Jun 2017 16:40:47 +0100
Subject: [PATCH v2 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
In-Reply-To: <20170613142837.29738-5-marc.zyngier@arm.com>
References: <20170613142837.29738-1-marc.zyngier@arm.com>
 <20170613142837.29738-5-marc.zyngier@arm.com>
Message-ID: <3598f402-172d-b901-f4b8-1f0050abcd24@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 13/06/17 15:28, Marc Zyngier wrote:
> +static inline int read_pmuver(void)
> +{
> +	u32 dfr0 = read_sysreg(ID_DFR0);
> +	int vers = (s8)((dfr0 >> 24) & 0xff);
> +
> +	if (vers < 3)
> +		vers = -1;
> +
> +	return vers;
> +}

Alternatively, PMU version can be extracted with existent helper:

int vers = cpuid_feature_extract(CPUID_EXT_DFR0, 24);

Not sure which of these two is preferred...

Cheers
Vladimir
