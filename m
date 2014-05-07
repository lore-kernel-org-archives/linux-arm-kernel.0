From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 07 May 2014 16:01:39 +0200
Subject: [PATCH] ARM: Kirkwood: DT versions of OpenRD boards
In-Reply-To: <20140507132950.GB23936@lunn.ch>
References: <1399416504-19140-1-git-send-email-andrew@lunn.ch>
 <5369E35C.2020006@gmail.com> <20140507132950.GB23936@lunn.ch>
Message-ID: <536A3CC3.6070600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 03:29 PM, Andrew Lunn wrote:
> On Wed, May 07, 2014 at 09:40:12AM +0200, Sebastian Hesselbarth wrote:
>> On 05/07/2014 12:48 AM, Andrew Lunn wrote:
>>> Create DTS files to describe the Marvell OpenRD boards.
>>>
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>> Tested-by: Francois Lorrain <francois.lorrain@gmail.com>
>>> ---
>> [...]
>>> +/dts-v1/;
>>> +
>>> +#include "kirkwood-openrd.dtsi"
>>> +
>>> +/ {
>>> +	model = "OpenRD Base";
>>> +	compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>>> +
>>> +	ocp at f1000000 {
>>> +		serial at 12100 {
>>> +			status = "okay";
>>
>> I see you used the "good template" this time ;) I again have some nits,
>> that either you can take care of or me in the cleanup patches. I guess
>> it depends on whatever goes in first. ;)
>
> The patch already depends on your patches, so i may as well do the
> cleanup. I need to fix "description" anyway.

Right, I noticed that after I sent the mail. As you already have some
fixes, you should take care of it.

[...]
>>> +/dts-v1/;
>>> +
>>> +#include "kirkwood-openrd.dtsi"
>>> +
>>> +/ {
>>> +	model = "OpenRD Client";
>>> +	compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>>> +
>>> +	ocp at f1000000 {
>>> +		i2c at 11000 {
>>> +			status = "okay";
>>> +			clock-frequency = <400000>;
>>> +			pinctrl-0 = <&pmx_twsi0>;
>>> +			pinctrl-names = "default";
>>
>> The default pinctrl should have been set by the SoC dtsi already.
>
> You only pointed this out for i2c. What else is it true for? I should
> go look at your patches.

KW DT cleanup sets default pinctrl for GBE1, UART0, UART1, SPI0, NAND,
I2C0 and I2C1 on 6282.

>>> +		mvsdio at 90000 {
>>> +			status = "okay";
>>> +			cd-gpios = <&gpio0 29 9>;
>>> +			status = "disabled";
>>
>> Any reason not to enable sdio?
>
> Only client and ultimate have an SD slot. Base does not. If i have it
> right, client.dts and ultimate.dts should be enabling it. I will
> double check.

Ah, ok. So it is an "odd man out"-situation again, i.e. there is one
out of the tree different again? I am fine with it.

Sebastian
