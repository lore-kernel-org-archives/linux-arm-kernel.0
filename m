From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 14 Mar 2018 14:15:21 +0000
Subject: [alsa-devel] [PATCH v4 02/24] soc: qcom: Add APR bus driver
In-Reply-To: <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
 <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
Message-ID: <b2b24ce9-2923-2dd5-f569-fbad80f3f706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/03/18 14:12, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
> [..]
>> +struct bus_type aprbus_type = {
>> +    .name        = "aprbus",
>> +    .match        = apr_device_match,
>> +    .probe        = apr_device_probe,
>> +    .remove        = apr_device_remove,
>> +    .force_dma    = true,
> 
> There is no need of force_dma now as machine driver is not child of apr. 
> Please remove it.

Thanks Rohit, Will remove it.


>> +};
>> +EXPORT_SYMBOL_GPL(aprbus_type);
>> +
>>
> 
