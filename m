From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri, 14 Feb 2014 18:35:25 +0100
Subject: How to select between different display timings?
In-Reply-To: <20140214150208.12417b11@ipc1.ka-ro>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
 <1375966287-6784-8-git-send-email-LW@KARO-electronics.de>
 <52FE1F2D.4010102@de.bosch.com> <20140214150208.12417b11@ipc1.ka-ro>
Message-ID: <52FE53DD.7040102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.02.2014 15:02, schrieb Lothar Wa?mann:
> Hi,
>
> Dirk Behme wrote:
>> Hi Lothar and Shawn,
>>
>> On 08.08.2013 14:51, Lothar Wa?mann wrote:
>>> - add Copyright header
>>> - use label references for better readability
>>> - sort the entries alphabetically
>>> - add some aliases used by U-Boot to edit the DT data
>>>
>>> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
>>> ---
>>>    arch/arm/boot/dts/imx28-tx28.dts |  693 +++++++++++++++++++++++++++++++++-----
>>>    1 files changed, 611 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
>>> index 37be532..866af60 100644
>>> --- a/arch/arm/boot/dts/imx28-tx28.dts
>>> +++ b/arch/arm/boot/dts/imx28-tx28.dts
>> ...
>>> +&lcdif {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &lcdif_ctrl_pins_a>;
>>> +       lcd-supply = <&reg_lcd>;
>>> +       display = <&display>;
>>> +       status = "okay";
>>> +
>>> +       display: display at 0 {
>>> +               bits-per-pixel = <32>;
>>> +               bus-width = <24>;
>>> +
>>> +               display-timings {
>>> +                       native-mode = <&timing5>;
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +                       timing0: timing0 {
> [...]
>>> +                       };
>>> +               };
>>> +       };
>>> +};
>>
>> Being no graphics expert, looking at above device tree change, I'd like
>> to understand how this can be used to switch between different display
>> timings?
>>
>> In the kernel, I've found the code which selects the default/native-mode
>> (of_display_timing.c). But, as here, if there is a native/default mode,
>> there are alternative modes. I haven't understood how and who to select
>> these other modes? In this case, how could the alternative modes
>> timing0/1/2/3/4 be selected in the kernel?
>>
>> Do you have any pointers regarding this?
>>
> You need to set the property 'native-mode' to the phandle of the
> display-timings entry like marked above.

Hmm, let's see if we talk about the same thing ;) Let me rephrase my 
questions:

Using above example and booting a system with the resulting .dtb, 
timing5 is selected at boot time, correct?

Assuming I want to use timing1 instead: who would set when the 
property 'native-mode' to &timing1?

Can the switch to

native-mode = <&timing1>;

only be done at compile time of the dts -> dtb? Or can this be done at 
boot/kernel run time, too?

In the end, I'm looking for a way to have several timings like above 
in the device tree, and select one at kernel boot time based on the 
display detected. Would this be possible?

Many thanks and best regards

Dirk
