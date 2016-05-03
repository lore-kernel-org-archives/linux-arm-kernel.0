From: oliver@schinagl.nl (Olliver Schinagl)
Date: Tue, 3 May 2016 09:21:06 +0200
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <CAGb2v66E2TuN3+tYaAbniV3q67waDZOfqKAW14VJz6xZFomZ=Q@mail.gmail.com>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
 <CAGb2v66E2TuN3+tYaAbniV3q67waDZOfqKAW14VJz6xZFomZ=Q@mail.gmail.com>
Message-ID: <57285162.2000704@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Chen,

On 03-05-16 05:33, Chen-Yu Tsai wrote:
> Hi,
>
> On Thu, Apr 28, 2016 at 3:19 PM, Olliver Schinagl <oliver@schinagl.nl> wrote:
>> There are 3 kinds of OLinuXino Lime2 boards.
>> One without any on board storage, one with NAND storage and one with
>> eMMC storage. This patch adds the eMMC variant of boards.
>>
>> eMMC storage is different from a regular SD card in that it is soldered
>> on the board and cannot be changed. Additionally, it shares pins with
>> the NAND module and with the second SPI port.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    | 64 ++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
>> new file mode 100644
>> index 0000000..689da36
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
>> @@ -0,0 +1,64 @@
>> + /*
>> + * Copyright 2015 - Ultimaker B.V.
>> + * Author Olliver Schinagl <oliver@schinagl.nl>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "sun7i-a20-olinuxino-lime2.dts"
>> +
>> +/ {
>> +       model = "Olimex A20-OLinuXino-LIME2-eMMC";
>> +};
>> +
>> +&mmc2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mmc2_pins_a>;
>> +       vmmc-supply = <&reg_vcc3v3>;
>> +       bus-width = <4>;
> Only 4 bits? We normally see eMMC with 8 bits. 4 bits are some kind of
> embedded SD card.
On A20 as well? Our investigations so far have concluded that the A10 
and A20 have those pins not mapped out to pads. The IP does support it 
however we assume.
>
>> +       non-removable;
>> +       no-1-8-v;
> This flag is not supported on sunxi.
>
> Instead, use the vqmmc-supply with the correct regulator and constraints.
That was not supposed to be there, i'll fix it! Sorry.
>
> ChenYu
>
>> +       status = "okay";
>> +
>> +       emmc: emmc at 0 {
>> +               reg = <0>;
>> +               compatible = "mmc-card";
>> +               broken-hpi;
>> +       };
>> +};
>> --
>> 2.8.0.rc3
>>
