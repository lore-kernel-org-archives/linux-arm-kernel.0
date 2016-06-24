From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Sat, 25 Jun 2016 00:39:52 +0200
Subject: [linux-sunxi] [PATCH 13/14] ARM: dts: sun8i: Add gpio-regulator
 used on Orange Pi One
In-Reply-To: <CAGRGNgWzfuA+ik25GvvoksGaxyp36_eMhaYm0x3XVkZks5gFfg@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-14-megous@megous.com>
 <CAGRGNgWzfuA+ik25GvvoksGaxyp36_eMhaYm0x3XVkZks5gFfg@mail.gmail.com>
Message-ID: <6a178035-9d0d-33ea-7afa-28a3bfb03dfe@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

thank you for the review. You're right. I added the pinctrl client
nodes. Also the patches were split incorrectly, so I fixed that too.

regards,
  Ondrej

On 24.6.2016 04:51, Julian Calaby wrote:
> Hi Ondrej,
> 
> On Fri, Jun 24, 2016 at 5:21 AM,  <megous@megous.com> wrote:
>> From: Ondrej Jirman <megous@megous.com>
>>
>> Xulong Orange Pi One uses GPIO based regulator that
>> switches between two voltages: 1.1V and 1.3V. The
>> regulator is controlled from the PL6 pin.
>>
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> index 0adf932..ce4ba91 100644
>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> @@ -88,6 +88,25 @@
>>                         gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
>>                 };
>>         };
>> +
>> +       vdd_soc: gpio-regulator {
>> +               compatible = "regulator-gpio";
>> +
>> +               regulator-name = "soc-vdd-supply";
>> +               regulator-min-microvolt = <1100000>;
>> +               regulator-max-microvolt = <1300000>;
>> +               regulator-boot-on;
>> +               regulator-type = "voltage";
>> +
>> +               gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
>> +               states = <1100000 0x0
>> +                         1300000 0x1>;
>> +
>> +               startup-delay-us = <100000>;
>> +               enable-active-high;
> 
> Don't you need to reference the new pinctl node in this one?
> 
> Thanks,
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/e57828ad/attachment.sig>
