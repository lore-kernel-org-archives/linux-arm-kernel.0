From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 9 Jan 2017 19:38:03 +0200
Subject: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
In-Reply-To: <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
References: <20170107085203.4431-5-krzk@kernel.org>
 <20170107091651.10560-1-krzk@kernel.org>
 <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
Message-ID: <CAJKOXPdODg2gCXP-BCRhDZAc2+o1J7Ek9iLaYF7hn_R2mNiK3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 6:24 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Krzysztof,
>
> I think it would had been clearer if the subject prefix was "[PATCH v1.1 4/4]" :)

Ah, yes.

>
> On 01/07/2017 06:16 AM, Krzysztof Kozlowski wrote:
>> Odroid U3 needs a power sequence for lan9730, if it was enabled by
>> bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
>> is present on Odroid U3).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>
> Do you think that makes sense to also enable GPIO_SYS for debugging
> purposes as you do in patch 3/4?

I like the GPIO_SYSFS interface because it is easy to use. However
now, after your question, I found this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470154.html
ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms

... so instead I will drop it from exynos_defconfig.

Best regards,
Krzysztof
