From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Apr 2016 17:10:40 +0100
Subject: [PATCH V2 14/15] coresight: tmc: implementing TMC-ETR AUX space
 API
In-Reply-To: <1460483692-25061-15-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-15-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5718FB80.90205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> This patch implement the AUX area interfaces required to
> use the TMC (configured as an ETR) from the Perf sub-system.
>
> The heuristic is heavily borrowed from the ETB10 and TMC-ETF
> implementation.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +static void tmc_update_etr_buffer(struct coresight_device *csdev,
> +				  struct perf_output_handle *handle,
> +				  void *sink_config)
> +{
> +	struct cs_etr_buffers *buf = sink_config;
> +
> +	/*
> +	 * An ETR configured to work in contiguous memory mode works the same
> +	 * was as an ETB or ETF.
> +	 */
> +	tmc_update_etf_buffer(csdev, handle, &buf->tmc);

Really ? I thought the ETR stores the data to the allocated System RAM and can
be read directly from the memory than using the RRD ?

Suzuki
