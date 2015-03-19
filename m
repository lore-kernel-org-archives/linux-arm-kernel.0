From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Thu, 19 Mar 2015 18:27:21 -0300
Subject: [PATCH v2] ARM: socfpga: dts: Add adxl34x
In-Reply-To: <CABxpGwCbFF+pJ0H_sMjqk6c9awdRuxi6j0CL_d3mH5z4Qht+ng@mail.gmail.com>
References: <1419462712-14151-1-git-send-email-walter@vanguardiasur.com.ar>
 <20150105092153.GJ13070@pengutronix.de>
 <CABxpGwCbFF+pJ0H_sMjqk6c9awdRuxi6j0CL_d3mH5z4Qht+ng@mail.gmail.com>
Message-ID: <CABxpGwAFdLET+fg3WvMWqXdzsPQHv3hKx9cFwk9RQE9w6+rEbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Mon, Mar 16, 2015 at 10:10 AM, Walter Lozano
<walter@vanguardiasur.com.ar> wrote:
> On Mon, Jan 5, 2015 at 6:21 AM, Steffen Trumtrar
> <s.trumtrar@pengutronix.de> wrote:
>> Hi!
>>
>> On Wed, Dec 24, 2014 at 08:11:52PM -0300, Walter Lozano wrote:
>>> This patch adds the DTS bindings for the adxl34x digital
>>> accelerometer.
>>>
>>> Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
>>> ---
>>>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>>> index 16ea6f5..d343e03 100644
>>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>>> @@ -60,6 +60,22 @@
>>>       rxc-skew-ps = <2000>;
>>>  };
>>>
>>> +&gpio2 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +     status = "okay";
>>> +
>>> +     accel1: accelerometer at 53 {
>>> +             compatible = "adxl34x";
>>> +             reg = <0x53>;
>>> +
>>> +             interrupt-parent = <&portc>;
>>> +             interrupts = <3 2>;
>>> +     };
>>> +};
>>> +
>>>  &mmc0 {
>>>       vmmc-supply = <&regulator_3_3v>;
>>>       vqmmc-supply = <&regulator_3_3v>;
>>
>> I just gave it a short spin. I get some interrupts and the position property
>> changes, so it seems to work:
>>
>>         Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>
> Ping?
> How should this continue?

Any news about this patch? It has been acked by Pavel Machek and
Steffen Trumtrar a while ago.

Regards,

-- 
Walter Lozano, VanguardiaSur
www.vanguardiasur.com.ar
