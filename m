From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 4 May 2017 21:29:27 -0700
Subject: [PATCH] ARM: dts: imx: add DH2228FV DAC to Gateworks Ventana
 boards with SPI
In-Reply-To: <20170505015653.GT18578@dragon>
References: <1493823894-2107-1-git-send-email-tharvey@gateworks.com>
 <20170505015653.GT18578@dragon>
Message-ID: <CAJ+vNU2hkrT-evWKGHauENOHp2jGjdbNpLaZx2nH=cARk5KFBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 6:56 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Wed, May 03, 2017 at 08:04:54AM -0700, Tim Harvey wrote:
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 6 ++++++
>>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 6 ++++++
>>  arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 6 ++++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> index 91991d6..b5c1a8f 100644
>> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> @@ -143,6 +143,12 @@
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_ecspi3>;
>>       status = "okay";
>> +
>> +     spidev0: spidev at 0 {
>> +             compatible = "rohm,dh2228fv";
>
> I do not see this is a documented compatible.
>
> Shawn
>

Shawn,

No, it doesn't seem to be documented in
Documentation/devicetree/bindings, but it is in the spidev driver:
https://lxr.missinglinkelectronics.com/linux/drivers/spi/spidev.c#L697

Regards,

Tim
