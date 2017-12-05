From: tyler@opensourcefoundries.com (Tyler Baker)
Date: Tue, 5 Dec 2017 12:59:00 -0800
Subject: [PATCH 3/8] ARM: dts: imx7d-cl-som: add nodes for usbh,
 and usbotg2
In-Reply-To: <CAOMZO5BX1K_WGiTosbph67=93aZR8Wjo+YKUHd16o8LvnD685Q@mail.gmail.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
 <20171130201434.14122-4-tyler@opensourcefoundries.com>
 <CAOMZO5BX1K_WGiTosbph67=93aZR8Wjo+YKUHd16o8LvnD685Q@mail.gmail.com>
Message-ID: <CAH=dhFTt1smoO_y-_kqgMhreijLhcuVqxAu3ViaT59jV07OqFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 12:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Nov 30, 2017 at 6:14 PM,  <tyler@opensourcefoundries.com> wrote:
>> From: Tyler Baker <tyler@opensourcefoundries.com>
>>
>> Add device tree nodes for the USB hub, and USB OTG. i2c2 on this
>> platform supports low state retention power state so lets use it.
>>
>> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
>> ---
>>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 36 +++++++++++++++++++++++++--------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> index ae45af1..a9f690b 100644
>> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> @@ -30,6 +30,16 @@
>>                 gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
>>                 enable-active-high;
>>         };
>> +
>> +       reg_usbh_nreset: regulator at 4 {
>
> You should not use @4. Please make sure that regulators are not used
> inside simple-bus.

Good catch, will fix.

>> -
>>         pinctrl_uart1: uart1grp {
>>                 fsl,pins = <
>>                         MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
>> @@ -284,4 +297,11 @@
>>                         MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5     0x14 /* OTG PWREN */
>>                 >;
>>         };
>> -};
>> \ No newline at end of file
>
> This text here looks strange :-)

Indeed, I'll scrub it.
