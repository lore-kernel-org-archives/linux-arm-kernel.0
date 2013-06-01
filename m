From: padma.kvr@gmail.com (Padma Venkat)
Date: Sat, 1 Jun 2013 14:36:27 +0530
Subject: [PATCH V3 0/4] clk: Samsung: audss: Register audio subsytem
 clocks using common clk framework
In-Reply-To: <51A9B0D1.2090408@gmail.com>
References: <1369735378-10003-1-git-send-email-padma.v@samsung.com>
 <51A9B0D1.2090408@gmail.com>
Message-ID: <CAAgF-BfSv2WYiZrPzbdsE+7ReoncOAf1gQn+N7A2yrETFb_D4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Sat, Jun 1, 2013 at 1:59 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> Padmavathi,
>
>
> On 05/28/2013 12:02 PM, Padmavathi Venna wrote:
>>
>> Samsung S5PV210 and Exynos SoC has a separate subsystem for audio. This
>> subsystem
>> has a internal clock controller which controls i2s0 and pcm0 clocks. This
>> patch
>> series adds the Samsung audio subsytem clock to the common clock framework
>> and
>> provides the I2S controllers clock information in the dtsi file.
>>
>> This patch series is made based on Kukjin Kim for-next branch
>>
>> Changes since V2:
>>         - Removed s5pv210 compatible name from driver as it is
>>           not yet supported which is different from Exynos series
>>           audio subsystem clock conroller.
>>         - Removed clkdev lookup support and added alias names in
>>           the i2s0 controller node.
>> Changes since V1:
>>          - Reworked on all review comments by Sylwester Nawrocki
>>          - Added a header file for all clock indexes as requested by
>> Sylwester
>>          - Added different compatible names for s5pv210, exynos4 and
>> exynos5
>>          - Registered the pcm clocks with common clock framework
>
>
> Overall it looks good to me. I'm only a bit uncomfortable with using
> SAMSUNG_
> prefix for the clock index definitions. Ideally it should be something more
> specific to the SoC family. But I can't think of anything better at the
> moment.
> This covers the Exynos and S5P SoCs, hence EXYNOS_ would not be appropriate.

Actuvally I added samsung prefix when I added s5pv210 compatible name.
 But I also feel
Exynos would be better now. I will resend the patch with Exynos prefix
and with your reviewed-by.

Thanks
Padma
>
> The patch series:
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Thanks,
> Sylwester
>
>
>> Padmavathi Venna (4):
>>    ARM: samsung: use #include for all device trees
>>    clk: samsung: register audio subsystem clocks using common clock
>>      framework
>>    ARM: dts: add Exynos audio subsystem clock controller node
>>    ARM: dts: add clock provider information for i2s controllers in
>>      Exynos5250
>>
>>   .../bindings/clock/clk-samsung-audss.txt           |   64 ++++++++++
>>   arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
>>   arch/arm/boot/dts/exynos4210-origen.dts            |    2 +-
>>   arch/arm/boot/dts/exynos4210-smdkv310.dts          |    2 +-
>>   arch/arm/boot/dts/exynos4210-trats.dts             |    2 +-
>>   arch/arm/boot/dts/exynos4210-universal_c210.dts    |    2 +-
>>   arch/arm/boot/dts/exynos4210.dtsi                  |    4 +-
>>   arch/arm/boot/dts/exynos4212.dtsi                  |    2 +-
>>   arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
>>   arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
>>   arch/arm/boot/dts/exynos4412-smdk4412.dts          |    2 +-
>>   arch/arm/boot/dts/exynos4412.dtsi                  |    2 +-
>>   arch/arm/boot/dts/exynos4x12.dtsi                  |    4 +-
>>   arch/arm/boot/dts/exynos5250-arndale.dts           |    2 +-
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts          |    2 +-
>>   arch/arm/boot/dts/exynos5250-snow.dts              |    4 +-
>>   arch/arm/boot/dts/exynos5250.dtsi                  |   23 +++-
>>   arch/arm/boot/dts/exynos5440-sd5v1.dts             |    2 +-
>>   arch/arm/boot/dts/exynos5440-ssdk5440.dts          |    2 +-
>>   arch/arm/boot/dts/exynos5440.dtsi                  |    2 +-
>>   arch/arm/boot/dts/s3c2416-smdk2416.dts             |    2 +-
>>   arch/arm/boot/dts/s3c2416.dtsi                     |    4 +-
>>   arch/arm/boot/dts/s3c24xx.dtsi                     |    2 +-
>>   drivers/clk/samsung/Makefile                       |    1 +
>>   drivers/clk/samsung/clk-samsung-audss.c            |  133
>> ++++++++++++++++++++
>>   include/dt-bindings/clk/samsung-audss-clk.h        |   25 ++++
>>   26 files changed, 269 insertions(+), 27 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/clock/clk-samsung-audss.txt
>>   create mode 100644 drivers/clk/samsung/clk-samsung-audss.c
>>   create mode 100644 include/dt-bindings/clk/samsung-audss-clk.h
