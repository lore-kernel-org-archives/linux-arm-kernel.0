From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 31 Aug 2016 10:24:59 +0900
Subject: [PATCH v2 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <20160830171146.GA22946@rob-hp-laptop>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
 <CGME20160830171208epcas1p106936bcf8c13e4f96b625cc65c414a4c@epcas1p1.samsung.com>
 <20160830171146.GA22946@rob-hp-laptop>
Message-ID: <57C631EB.2080401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2016? 08? 31? 02:11, Rob Herring wrote:
> On Wed, Aug 24, 2016 at 10:49:10PM +0900, Chanwoo Choi wrote:
>> This patch adds the Device Tree source for Exynos5433-based Samsung TM2 board.
>> This board fully support the all things for mobile target.
>>
>> This patch supports the following devices:
>> 1. basic SoC
>> - Initial booting for Samsung Exynos5433 SoC
>> - DRAM LPDDR3 (3GB)
>> - eMMC (32GB)
>> - ARM architecture timer
>>
>> 2. power management devices
>> - Sasmung S2MPS13 PMIC for the power supply
>> - CPUFREQ for big.LITTLE cores
>> - TMU for big.LITTLE cores and GPU
>> - ADC with thermistor to measure the temperature of AP/Battery/Charger
>> - Maxim MAX77843 Interface PMIC (MUIC/Haptic/Regulator)
>>
>> 3. sound devices
>> - I2S for sound bus
>> - LPASS for sound power control
>> - Wolfson WM5110 for sound codec
>> - Maxim MAX98504 for speaker amplifier
>> - TM2 ASoC Machine device driver node
>>
>> 3. display devices
>> - DECON, DSI and MIC for the panel output
>>
>> 4. usb devices
>> - USB 3.0 DRD (Dual Role Device)
>> - USB 3.0 Host controller
>>
>> 5. storage devices
>> - MSHC (Mobile Storae Host Controller) for eMMC device
>>
>> 6. misc devices
>> - gpio-keys (power, volume up/down, home key)
>> - PWM (Pulse Width Modulation Timer)
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Inha Song <ideal.song@samsung.com>
>> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  .../bindings/arm/samsung/samsung-boards.txt        |   1 +
>>  arch/arm64/boot/dts/exynos/Makefile                |   5 +-
>>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 985 +++++++++++++++++++++
>>  3 files changed, 990 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> index 0ea7f14ef294..c704b4bf6137 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> @@ -15,6 +15,7 @@ Required root node properties:
>>  	- "samsung,xyref5260"	- for Exynos5260-based Samsung board.
>>  	- "samsung,smdk5410"	- for Exynos5410-based Samsung SMDK5410 eval board.
>>  	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
>> +	- "samsung,tm2"		- for Exynos5333-based Samsung TM2 board.
> 
> This does not match...

It is my mistake. Exynos5433 is correct. I'll fix it.

> 
>> +	compatible = "samsung,exynos5433-tm2", "samsung,exynos5433";
> 
> Is it 5433 or 5333?
> 
>> +
>> +	aliases {
>> +		pinctrl0 = &pinctrl_alive;
>> +		pinctrl1 = &pinctrl_aud;
>> +		pinctrl2 = &pinctrl_cpif;
>> +		pinctrl3 = &pinctrl_ese;
>> +		pinctrl4 = &pinctrl_finger;
>> +		pinctrl5 = &pinctrl_fsys;
>> +		pinctrl6 = &pinctrl_imem;
>> +		pinctrl7 = &pinctrl_nfc;
>> +		pinctrl8 = &pinctrl_peric;
>> +		pinctrl9 = &pinctrl_touch;
> 
> Drop all these.

As I said on previous reply on v1 patches,
The alias of both pinctrl and spi are used on the pinctrl/spi driver.
If I drop the alias of both pinctrl and spi, the error happened.

> 
>> +		serial0 = &serial_0;
>> +		serial1 = &serial_1;
>> +		serial2 = &serial_2;
>> +		serial3 = &serial_3;
> 
>> +		spi0 = &spi_0;
>> +		spi1 = &spi_1;
>> +		spi2 = &spi_2;
>> +		spi3 = &spi_3;
>> +		spi4 = &spi_4;
> 
> And these.

ditto.

-- 
Best Regards,
Chanwoo Choi
