From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 05 Mar 2013 11:24:08 +0100
Subject: [PATCH] ARM: dts: Modify SPI nodes according generic DMA DT
 bindings
In-Reply-To: <CAK9yfHwmjwN4ceCQ719Y2DY9keTEX8mt65bHkoHcTTRJc5p9rA@mail.gmail.com>
References: <1362477862-352-1-git-send-email-padma.v@samsung.com>
 <CAK9yfHwmjwN4ceCQ719Y2DY9keTEX8mt65bHkoHcTTRJc5p9rA@mail.gmail.com>
Message-ID: <5135C7C8.9030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 11:06 AM, Sachin Kamat wrote:
> On 5 March 2013 15:34, Padmavathi Venna <padma.v@samsung.com> wrote:
>> This patch removes custom way of adding spi dma channels and
>> adds according to new generic DMA DT bindings on samsung exynos4
>> and exynos5440 platforms.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4.dtsi    |   15 +++++++++------
>>  arch/arm/boot/dts/exynos5440.dtsi |    5 +++--
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
...
>> @@ -246,8 +247,9 @@
>>                 compatible = "samsung,exynos4210-spi";
>>                 reg = <0x13930000 0x100>;
>>                 interrupts = <0 67 0>;
>> -               tx-dma-channel = <&pdma1 7>; /* preliminary */
>> -               rx-dma-channel = <&pdma1 6>; /* preliminary */
>> +               dmas = <&pdma0 7
>> +                       &pdma0 6>;
> 
> Shouldn't these be pdma1 as was earlier?

Yes, it should. And this is also what the SoC documentation says - SPI1 is
assigned to Peri DMA1.
