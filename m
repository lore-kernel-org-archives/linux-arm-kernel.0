From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 30 Sep 2015 14:48:04 +0800
Subject: [PATCH v5 02/17] drm: bridge: analogix/dp: split exynos dp driver
 to bridge directory
In-Reply-To: <560B7068.2000008@samsung.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <1442906963-2883-1-git-send-email-ykk@rock-chips.com>
 <560B7068.2000008@samsung.com>
Message-ID: <560B85A4.2040907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 09/30/2015 01:17 PM, Krzysztof Kozlowski wrote:
> On 22.09.2015 16:29, Yakir Yang wrote:
>> Split the dp core driver from exynos directory to bridge directory,
>> and rename the core driver to analogix_dp_*, rename the platform
>> code to exynos_dp.
>>
>> Beside the new analogix_dp driver would export four hooks.
>> "analogix_dp_bind()" and "analogix_dp_unbind()"
>> "analogix_dp_detect()" and "analogix_dp_get_modes()"
>>
>> The bind/unbind symbols is used for analogix platform driver to connect
>> with analogix_dp core driver. And the detect/get_modes is used for analogix
>> platform driver to init the connector.
>>
>> They reason why connector need register in helper driver is rockchip drm
>> haven't implement the atomic API, but Exynos drm have implement it, so
>> there would need two different connector helper functions, that's why we
>> leave the connector register in helper driver.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v5:
>> - Correct the check condition of gpio_is_valid when driver try to get
>>    the "hpd-gpios" DT propery. (Heiko)
>> - Move the platform attach callback in the front of core driver bridge
>>    attch function. Cause once platform failed at attach, core driver should
>>    still failed, so no need to init connector before platform attached (Krzysztof)
>> - Keep code style no changes with the previous exynos_dp_code.c in this
>>    patch, and update commit message about the new export symbol (Krzysztof)
>> - Gather the device type patch (v4 11/16) into this one. (Krzysztof)
>> - leave out the connector registration to analogix platform driver. (Thierry)
> Thanks for fixing this, looks much better.
>
> I don't feel comfortable enough to provide a review tag but it looks
> good to me.

Thanks  ;)

- Yakir

> Best regards,
> Krzysztof
>
>
>
>
