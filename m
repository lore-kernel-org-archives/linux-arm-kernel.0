From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 27 Mar 2018 20:42:02 +0800
Subject: [PATCH 0/3] clk: meson: drop unnecessary AO clock flags
In-Reply-To: <1522142509.2632.42.camel@baylibre.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
 <1522142509.2632.42.camel@baylibre.com>
Message-ID: <c99b705b-f98a-4b77-7113-78dec326d9b6@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Jerome

On 03/27/2018 05:21 PM, Jerome Brunet wrote:
> On Mon, 2018-03-26 at 16:18 +0800, Yixun Lan wrote:
>>   This first two patches will drop unnecessary flags for
>> the AO clock driver.
>>   The third DTS patch is a follow-up fix for the second patch,
>> and I've tested them on P200, P212, Q200, S400 boards.
>>
>>  Note: this patch series was made on top of patch [0]
>>
>> [0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
>>
>> Yixun Lan (3):
>>   clk: meson: drop CLK_SET_RATE_PARENT flag
>>   clk: meson: drop CLK_IGNORE_UNUSED flag
>>   ARM64: dts: meson: fix clock source of the pclk for UART_AO
> 
> Please add patch 1 and 2 to the next version of your clkc_ao series
> 
I was thinking about patch 1 & 2 as independent patch of the clkc_ao
series..

anyway, as your suggestion in another thread,
I could include the patch 1 into next clkc_ao series
send patch 3 (DTS part) independently to Kevin, once patch 3 accepted
into mainline, I will then send patch 2 as a fix
(this will avoid breaking bisect)

> Patch 3 should sent independently to Kevin, with note warning about the
> different dependencies (see comment in patch 3)
> 
>>
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
>>  drivers/clk/meson/axg-aoclk.c               | 1 -
>>  drivers/clk/meson/gxbb-aoclk.c              | 1 -
>>  5 files changed, 6 insertions(+), 8 deletions(-)
>>
> 
> .
> 
