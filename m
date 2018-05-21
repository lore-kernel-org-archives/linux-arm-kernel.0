From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 21 May 2018 10:34:19 +0100
Subject: [PATCH v3 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
In-Reply-To: <20180518143913.26306-5-marc.zyngier@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <20180518143913.26306-5-marc.zyngier@arm.com>
Message-ID: <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/18 15:39, Marc Zyngier wrote:
> +static inline int read_pmuver(void)
> +{
> +	/* PMUVers is not a signed field */
> +	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
> +	return (dfr0 >> 24) & 0xf;
> +}

Should we rule out versions prior v3 here or in __armv8pmu_probe_pmu()?

Thanks
Vladimir
