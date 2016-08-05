From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 05 Aug 2016 08:22:13 -0700
Subject: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
In-Reply-To: <20160805034623.GA1883@excalibur.cnev.de> (Karsten Merker's
 message of "Fri, 5 Aug 2016 05:46:23 +0200")
References: <20160803231843.23012-1-khilman@baylibre.com>
 <20160805034623.GA1883@excalibur.cnev.de>
Message-ID: <m2fuqjmeai.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karsten Merker <merker@debian.org> writes:

> On Wed, Aug 03, 2016 at 04:18:42PM -0700, Kevin Hilman wrote:
>
>> Add binding and basic support for the SD/eMMC controller on Amlogic
>> S905/GXBB devices.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt | 29 +++++++++
>>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 74 ++++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 71 +++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 36 ++++++++++-
>>  4 files changed, 209 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
>> new file mode 100644
>> index 000000000000..2bfdf47018c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
>> @@ -0,0 +1,29 @@
>> +Amlogic SD / eMMC controller for S905/GXBB family SoCs
>> +
>> +The MMC 5.1 compliant host controller on Amlogic provides the
>> +interface for SD, eMMC and SDIO devices.
>> +
>> +This file documents the properties in addition to those available in
>> +the MMC core bindings, documented by mmc.txt.
>> +
>> +Required properties:
>> +- compatible : contains "amlogic,meson-gxbb"
>
> I assume that should be "amlogic,meson-gxbb-mmc" instead of
> "amlogic,meson-gxbb", shouldn't it?

Correct, thanks for the review.

Kevin
