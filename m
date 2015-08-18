From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 18 Aug 2015 17:09:33 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable CROS_EC_PROTO for ChromeOS
 EC mfd driver
In-Reply-To: <55D2E767.50807@osg.samsung.com>
References: <1439881281-22054-1-git-send-email-javier@osg.samsung.com>
 <55D2E569.3000800@samsung.com> <55D2E767.50807@osg.samsung.com>
Message-ID: <55D2E83D.70206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.08.2015 17:05, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 08/18/2015 09:57 AM, Krzysztof Kozlowski wrote:
>> On 18.08.2015 16:01, Javier Martinez Canillas wrote:
>>> The ChromeOS mfd driver (MFD_CROS_EC) select the CROS_EC_PROTO config
>>> symbol because the driver uses some communication helper functions in
>>> drivers/platform/chrome/cros_ec_proto.c but other drivers depends on
>>> CROS_EC_PROTO instead. Mixing select and depends can lead to circular
>>> Kconfig dependencies so the MFD_CROS_EC select should be changed to a
>>> depends on CROS_EC_PROTO instead.
>>>
>>> But doing so will break git bisect-ability since MFD_CROS_EC will not
>>> be enabled anymore unless the default configs first explicitly enable
>>> the CROS_EC_PROTO dependency.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> ---
>>>  arch/arm/configs/exynos_defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> I saw the discussion about circular dependency but I wasn't following
>> it. Currently the CROS_EC_PROTO is not user-selectable. How can you
>> depend on it? How can be enabled on different configs (customized by user)?
>>
>> Maybe the questions are answered by code in different patches?
> 
> Yes, that's why I posted "[PATCH] platform/chrome: Make CROS_EC_PROTO
> a user selectable option" [0].
> 
> I posted as separate patches because there isn't a dependency between
> them and once all the defconfig patches and the patch to make the
> CROS_EC_PROTO symbol user selectable lands, I'll post the patch to
> change select for depends on to avoid a regression.

Makes sense now.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

> 
> Maybe I should had posted as a series (or at least cc all the people
> in all the patches) to not left these questions unanswered...

Yep, Cc-ing or a short cover letter would probably answer my question. :)

Best regards,
Krzysztof
