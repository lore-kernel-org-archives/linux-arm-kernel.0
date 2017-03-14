From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 15:09:25 +0200
Subject: [PATCH v2 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
In-Reply-To: <6788694.7QfyuOlrPv@amdc3058>
References: <20170311172527.16368-1-krzk@kernel.org>
 <CGME20170314130352epcas5p472cdaa4ae512b4a839d92e85d6dadb81@epcas5p4.samsung.com>
 <20170311172527.16368-4-krzk@kernel.org> <6788694.7QfyuOlrPv@amdc3058>
Message-ID: <CAJKOXPcoP7c=TTFtWqBLMXT0BS_yi3fpu8X3q4sxCTM9m=mPmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 3:03 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Saturday, March 11, 2017 07:25:22 PM Krzysztof Kozlowski wrote:
>> The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
>> Just like the others, for working it requires additional steps in Power
>> Management Unit: unmasking the reset request and enabling the system
>> reset.  Without these additional steps in PMU, the watchdog will not be
>> able to reset the system on expiration event.
>>
>> Change the compatible of Exynos4412 watchdog device node to
>> samsung,exynos5250-wdt which includes the additional PMU steps.
>
> This is going to confuse people.  How's about doing it cleanly
> (by adding samsung,exynos4412-wdt compatible and convert existing
> users to use instead)?

I don't find usage of 5250 in Exynos4412 DTS as confusing because
since long time I do not threat these numbers as having any meaning
(e.g. 3250 is newer...). Yes, we can duplicate the compatible for that
purpose. Care to send a patch for this?

Best regards,
Krzysztof
