From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Aug 2014 09:14:56 -0700
Subject: [PATCH v7] ARM: dts: Prepare node labels for exynos5250
In-Reply-To: <080101cfbdf6$c8fd1f30$5af75d90$@samsung.com>
References: <53DCD74B.8090400@gmail.com>
 <1408539764-5835-1-git-send-email-afaerber@suse.de>
 <080101cfbdf6$c8fd1f30$5af75d90$@samsung.com>
Message-ID: <CAD=FV=VS8e4Fs-j4CFvGYtvj58QwOk52gWh7AfnZcpswVRnDKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Fri, Aug 22, 2014 at 3:49 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Andreas F?rber wrote:
>>
>> Allows them to be extended by reference.
>>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v6 -> v7:
>>  * Dropped uart* labels (Tomasz Figa)
>>
>>  v6: Split off from Snow/SMDK cleanups (Doug Anderson)
>>
>>  arch/arm/boot/dts/exynos5250.dtsi | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 492e1eff37bd..42eafd19cfb2 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -218,7 +218,7 @@
>>               clock-names = "fimg2d";
>>       };
>>
>> -     codec at 11000000 {
>> +     mfc: codec at 11000000 {
>>               compatible = "samsung,mfc-v6";
>>               reg = <0x11000000 0x10000>;
>>               interrupts = <0 96 0>;
>> @@ -227,7 +227,7 @@
>>               clock-names = "mfc";
>>       };
>>
>> -     rtc at 101E0000 {
>> +     rtc: rtc at 101E0000 {
>>               clocks = <&clock CLK_RTC>;
>>               clock-names = "rtc";
>>               status = "disabled";
>> @@ -261,7 +261,7 @@
>>               clock-names = "uart", "clk_uart_baud0";
>>       };
>>
>> -     sata at 122F0000 {
>> +     sata: sata at 122F0000 {
>>               compatible = "snps,dwc-ahci";
>>               samsung,sata-freq = <66>;
>>               reg = <0x122F0000 0x1ff>;
>> @@ -573,7 +573,7 @@
>>               #phy-cells = <1>;
>>       };
>>
>> -     usb at 12110000 {
>> +     ehci: usb at 12110000 {
>
> I'm not sure which one is recommended between above and "ehci: ehci at 12110000 {"

My understanding is that more generic names should be used for node
names.  AKA: "usb" and not "ehci".  "mmc" and not "dwmmc".

In another thread I was pointed at ePAPR
<http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf>:

The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model.


>> -     hdmi {
>> +     hdmi: hdmi {
>
> Should be
>
> +       hdmi: hdmi at 14530000 { ?

Seems like that should be a followon patch.
