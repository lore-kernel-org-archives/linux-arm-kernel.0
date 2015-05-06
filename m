From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 06 May 2015 15:48:13 +0200
Subject: ARM: EXYNOS: dts: Improvements for 4.2
In-Reply-To: <CAJKOXPfQO+Zd9njc3VGTQPcE2d=5hF8H-RpURCJMfA8kV8ZnWA@mail.gmail.com>
References: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>	<5549E1AB.8000400@collabora.co.uk>
 <CAJKOXPfQO+Zd9njc3VGTQPcE2d=5hF8H-RpURCJMfA8kV8ZnWA@mail.gmail.com>
Message-ID: <554A1B9D.3060405@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/06/2015 12:32 PM, Krzysztof Kozlowski wrote:
> 2015-05-06 18:40 GMT+09:00 Javier Martinez Canillas
> <javier.martinez@collabora.co.uk>:
>> Hello Krzysztof,
>>
>> On 05/06/2015 02:59 AM, Krzysztof Kozlowski wrote:
>>> Dear Kukjin,
>>>
>>> I gathered various improvements for upcoming 4.2 merge window.
>>> Description along with a tag.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>> ----------------------------------------------------------------
>>> The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:
>>>
>>>   Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/krzk/linux.git tags/samsung-dt-for-next-4.2
>>>
>>> for you to fetch changes up to 98155ec454a40212434c83c1388c420a61d62854:
>>>
>>>   ARM: dts: exynos4: add nodes for jpeg codec (2015-05-05 19:19:18 +0900)
>>>
>>> ----------------------------------------------------------------
>>> Device Tree improvements for Exynos based boards:
>>> 1. Fix PMIC's RTC alarm on Arndale Octa (S2MPS11 PMIC) and SMDK5250 (MAXIM77686
>>>    PMIC).
>>> 2. Fix suspend on Peach Pit Chromebooks prevented by Marvell mwifiex
>>>    driver.
>>> 3. Fix hang on Odroid XU3 on MMC card detect.
>>> 4. Enable the S3C RTC (the clock present on SoC) on various Exynos boards.
>>> 5. Minor improvements to S3C RTC driver.
>>> 6. Add nodes for JPEG codec on Exynos4.
>>>
>>> ----------------------------------------------------------------
>>> Andrzej Hajda (1):
>>>       ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
>>>
>>> Javier Martinez Canillas (2):
>>>       ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420
>>
>> This one is already in your "ARM: EXYNOS: dts: DTS fixes for 4.1" pull
>> request so it seems is a left over and should not be in this branch?
> 
> Yes, I rebased the work for v4.2 on top of fixes. Typically one would
> not send fixes and for-next release pull at the same time. Anyway it
> should not harm as merging or rebasing would ignore such commits.
> 
>>
>>>       ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards
>>>
>>
>> This patch is also rc material IMHO since the mwifiex driver prevents
>> the system to enter into a suspend state and the driver is enabled in
>> exynos_defconfig after commit "040464888a1a ("ARM: exynos_defconfig:
>> Enable Marvell WiFi-Ex support") which landed in v4.1-rc1.
> 
> That information was missing. I suspected this was a fix for an older
> issue not for regression introduced in 4.1-rc1. Now I agree.
> 

Technically you are right since the fix is for an old issue that was just
exposed when the driver was enabled by default. But yes, sorry for not
adding that information in the commit message and making it more clear.

Also, I thought that fixes were always a good candidate for the -rc cycle
even if the regression was not introduced during the last merge window.

IOW, it is better to fix issues sooner rather than later.

> Dear Kukjin, could pick this patch also for current RC cycle?
>

Thanks a lot.

> Best regards,
> Krzysztof
> 

Best regards,
Javier
