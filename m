From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 29 Oct 2015 15:59:31 +0900
Subject: [PATCH v3 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <006b01d11216$9831dc40$c89594c0$@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <048021141f295b0e70c852134d4ac9cc6f7f1da4.1446018918.git.p.fedin@samsung.com>
 <56318175.6000006@samsung.com> <006b01d11216$9831dc40$c89594c0$@samsung.com>
Message-ID: <5631C3D3.1050309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2015 15:54, Pavel Fedin wrote:
>  Hello!
> 

Where is the contents of email and patch?

>>> +	for_each_child_of_node(np, child)
>>> +		decode_sromc(srom, child);
>>
>> You ignore the return value here so bank may be not configured but
>> device probe will return 0.
> 
>  Yes, so that banks which are described correctly, will still be configured.

But the system won't get any information about the failure. Device using
these banks should not probe in such case.

> 
>> Maybe clean up and fail the probe?
> 
>  I think it's not fatal, so cleanup is not necessary. May be dev_warn() in this case?

Now this is just silently ignoring return value (which is not needed
then) and not printing any errors. But that actually depends on previous
comment - whether the driver will fail the probe.

Best regards,
Krzysztof
