From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 15:16:24 +0000
Subject: [PATCH v6 10/12] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <1453720877-24962-11-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
 <1453720877-24962-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160222151623.GH3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple more comments for things i just realised:

> +	/*
> +	 * Now that all the counters are disabled, we can safely turn the PMU on,
> +	 * without syncing the status of the counters
> +	 */
> +	__cci_pmu_enable(cci_pmu, CCI_CNTRS_NOSYNC);

As per my other comment, __cci_pmu_enable_nosync(cci_pmu) would be
preferable.

[...]

> +		pmu_write_counter(cci_pmu,
> +				  (u32)local64_read(&event->hw.prev_count), i);

That cast can go.

Mark.
