From: weiyj_lk@163.com (Wei Yongjun)
Date: Thu, 7 Jul 2016 20:09:38 +0800
Subject: [PATCH -next v2] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
In-Reply-To: <577E2442.4000002@samsung.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <1467860372-6940-1-git-send-email-weiyj_lk@163.com>
 <577E2442.4000002@samsung.com>
Message-ID: <fe43720e-52ff-72c9-36a7-0d3410e6d86d@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 05:43 PM, Krzysztof Kozlowski wrote:
> On 07/07/2016 04:59 AM, weiyj_lk at 163.com wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function of_platform_device_create() returns
>> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
>> check should be replaced with NULL test.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>> v1 -> v2: chenge the error code to -ENODEV
>> ---
>>   drivers/iommu/exynos-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> Why you didn't include mine and Dennis reviews? Why you ignored my
> comments - you don't agree with them?
>
Sorry, I missed your last mail. I will change patch as your advise.

Regards,
Yongjun Wei
