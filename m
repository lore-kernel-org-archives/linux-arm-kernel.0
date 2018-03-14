From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Wed, 14 Mar 2018 19:42:01 +0530
Subject: [alsa-devel] [PATCH v4 02/24] soc: qcom: Add APR bus driver
In-Reply-To: <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
Message-ID: <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
[..]
> +struct bus_type aprbus_type = {
> +	.name		= "aprbus",
> +	.match		= apr_device_match,
> +	.probe		= apr_device_probe,
> +	.remove		= apr_device_remove,
> +	.force_dma	= true,

There is no need of force_dma now as machine driver is not child of apr. 
Please remove it.
> +};
> +EXPORT_SYMBOL_GPL(aprbus_type);
> +
>
