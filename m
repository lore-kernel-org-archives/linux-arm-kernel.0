From: carlo@endlessm.com (Carlo Caione)
Date: Thu, 1 Sep 2016 23:28:34 +0200
Subject: [PATCH v3 6/6] ARM64: dts: amlogic: gxbb: Enable NVMEM
In-Reply-To: <m2bn07ia64.fsf@baylibre.com>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
 <1472305428-16874-7-git-send-email-carlo@caione.org>
 <m2bn07ia64.fsf@baylibre.com>
Message-ID: <CAL9uMOEo8VOqF95ZLrPuwmg=C67jABzfErnggN8_y_S3ObEe8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 11:26 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Carlo,
>
> Carlo Caione <carlo@caione.org> writes:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Add the NVMEM device node in the DTSI.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 18 ++++++++++++++++++
>>  drivers/firmware/meson/meson_sm.c           |  3 ++-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> index ca428e8..aea8fd6 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> @@ -105,6 +105,24 @@
>>               };
>>       };
>>
>> +     efuse: efuse {
>> +             compatible = "amlogic,meson-gxbb-efuse";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +
>> +             sn: sn at 14 {
>> +                     reg = <0x14 0x10>;
>> +             };
>> +
>> +             eth_mac: eth_mac at 34 {
>> +                     reg = <0x34 0x10>;
>> +             };
>> +
>> +             bid: bid at 46 {
>> +                     reg = <0x46 0x30>;
>> +             };
>> +     };
>> +
>>       timer {
>>               compatible = "arm,armv8-timer";
>>               interrupts = <GIC_PPI 13
>> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
>> index bba594e..b0d2549 100644
>> --- a/drivers/firmware/meson/meson_sm.c
>> +++ b/drivers/firmware/meson/meson_sm.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/printk.h>
>>  #include <linux/types.h>
>> +#include <linux/sizes.h>
>>
>>  #include <linux/firmware/meson/meson_sm.h>
>>
>> @@ -38,7 +39,7 @@ struct meson_sm_chip {
>>  };
>>
>>  struct meson_sm_chip gxbb_chip = {
>> -     .shmem_size             = 0x1000,
>> +     .shmem_size             = SZ_4K,
>>       .cmd_shmem_in_base      = 0x82000020,
>>       .cmd_shmem_out_base     = 0x82000021,
>>       .cmd = {
>
> This change doesn't reallly belong in this patch, and driver changes in
> DT patches makes it hard to keep the DT changes separate from driver
> changes, which is how we like to manage things in arm-soc.

Damn. Sorry, probably amended the wrong patch when trying to address
mark's comments.

> I've dropped it from this patch, and folded it into PATCH 1/6.

Where it belongs.

Thank you,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
