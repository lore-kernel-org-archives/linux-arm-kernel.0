From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Nov 2018 10:11:01 +0100
Subject: [PATCH v2 0/4] clk: meson: Add video clocks path
In-Reply-To: <f7679f4c93aca9a11b9078611b6c4952e83c9a9e.camel@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
 <f7679f4c93aca9a11b9078611b6c4952e83c9a9e.camel@baylibre.com>
Message-ID: <5137a72c-e5fa-6fad-f1b6-e64968e78391@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2018 15:18, jbrunet at baylibre.com wrote:
> On Tue, 2018-11-06 at 15:57 +0100, Neil Armstrong wrote:
>> This patchset is an attempt to handle the Amlogic Meson GX Video clock
>> in the Common Clock Framework in order to move the video pipeline and
>> HDMI controller clock management out of the Meson DRM Driver.
>>
>> In order :
>> - Add support the VID_PLL fully programmable divider used right after the
>>   HDMI PLL clock source.
>> - Fix the GXL HDMI PLL DCO
>> - Add the video clock bindings covering all the video graphics pipeline
>>   and the HDMI controller.
>> - Add the clocks entries used in the video clock path
>>
>> The vid_pll programmable divider is introduced in its R/O form right now,
>> but will be extended to be R/W in a next iteration.
>>
>> All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are
>> flagged
>> with CLK_IGNORE_UNUSED since they are currently directly handled by the
>> Meson DRM Driver.
>>
>> Once the DRM Driver is fully migrated to using the Common Clock Framework
>> to handle the video clock tree, the CLK_GET_RATE_NOCACHE and
>> CLK_IGNORE_UNUSED
>> will be dropped.
>>
>> Changes since v1 at [1]:
>>  - Fixed comments from Martin
>>  - Fixed GXL HDMI PLL DCO
>>  - Added the missing HDMI controller clock
>>  - Moved bindings to a separate patch
>>  - Updated the commit logs
>>
>> [1] 
>> https://lkml.kernel.org/r/1532079581-978-1-git-send-email-narmstrong at baylibre.com
>>
>> Neil Armstrong (4):
>>   clk: meson: Add vid_pll divider driver
>>   clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
>>   dt-bindings: clk: meson-gxbb: Add Video clock bindings
>>   clk: meson-gxbb: Add video clocks
>>
>>  drivers/clk/meson/Makefile            |   2 +-
>>  drivers/clk/meson/clkc.h              |   6 +
>>  drivers/clk/meson/gxbb.c              | 773
>> +++++++++++++++++++++++++++++++++-
>>  drivers/clk/meson/gxbb.h              |  26 +-
>>  drivers/clk/meson/vid-pll-div.c       |  91 ++++
>>  include/dt-bindings/clock/gxbb-clkc.h |  18 +
>>  6 files changed, 911 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/clk/meson/vid-pll-div.c
>>
> 
> Looks sane enough ;)
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Thanks, applied on next/drivers !
