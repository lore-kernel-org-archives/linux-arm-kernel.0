From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 17:42:37 +0100
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
In-Reply-To: <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170427164237.GA7114@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 05:16:23PM +0530, Geetha sowjanya wrote:
> +	/*
> +	 * Override the size, for Cavium CN99xx implementations
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
> +	if (cpu_model == MIDR_THUNDERX_99XX ||
> +	    cpu_model == MIDR_BRCM_VULCAN)
> +		size = SZ_64K;

If you're trying to identify an SMMU erratum, identify the SMMU, not the
CPU it happens to be paired with this time.

There are ID registers in the SMMU you can use to do so.

NAK to using the CPU ID here.

Mark.
