From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Nov 2017 08:51:38 +0100
Subject: [PATCH v2 1/2] ARM: dts: exynos: Switch to dedicated Odroid-XU3
 sound card binding
In-Reply-To: <46152007-e599-23eb-6a07-cc5f3ff32c70@samsung.com>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165539epcas1p48cc87811574dace9dfe91d8e9ec6f7ca@epcas1p4.samsung.com>
 <20171103165446.15438-2-s.nawrocki@samsung.com>
 <20171127181213.lxtbbiw75wbz2dbz@kozik-lap>
 <CAJKOXPegJsQPrbDH8mXBhypOBnT9+Nn1T6NF=Cav=PV+9b-2MA@mail.gmail.com>
 <46152007-e599-23eb-6a07-cc5f3ff32c70@samsung.com>
Message-ID: <CAJKOXPdCWfs3P5Zn7oN1DoTDvT7vVX4VhaixgU6JU6as1he-HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 8:30 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2017-11-29 18:55, Krzysztof Kozlowski wrote:
>>
>> On Mon, Nov 27, 2017 at 7:12 PM, Krzysztof Kozlowski <krzk@kernel.org>
>> wrote:
>>>
>>> On Fri, Nov 03, 2017 at 05:54:45PM +0100, Sylwester Nawrocki wrote:
>>>>
>>>> The new sound card DT binding is used for Odroid XU3 in order
>>>> to properly support the HDMI audio path.
>>>> Clocks configuration is changed so the I2S controller is now the bit
>>>> and the frame clock master with EPLL as the root clock source.
>>>>
>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>> ---
>>>>   arch/arm/boot/dts/exynos4.dtsi                    |  1 +
>>>>   arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
>>>>   arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 60
>>>> ++++++++++++++---------
>>>>   3 files changed, 40 insertions(+), 22 deletions(-)
>>>>
>>
>> Unfortunately this patch causes the audio card to disappear on Odroid
>> XU3. "aplay -L" shows nothing and obviously speaker-test fails.
>>
>> Applied on v4.15-rc1... any dependencies are missing?
>>
>> Full boot-logs are here:
>> http://www.krzk.eu/#/builders/1/builds/976
>> (test exits on aplay -L).
>>
>> Should this be dropped?
>
>
> Please add CONFIG_SND_SOC_ODROID=y to you .config. Probably exynos_defconfig
> and multi_v7_defconfig should be updated too.

That would explain it. Can you send a patch for both of configs?

Best regards,
Krzysztof
