From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:41:11 +0800
Subject: [PATCH 4/7] ARM: dts: sunxi: Add dtsi for AXP81x PMIC
In-Reply-To: <20170929083251.3akrjkujbqeqbh2x@flea>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-5-wens@csie.org>
 <20170929083251.3akrjkujbqeqbh2x@flea>
Message-ID: <CAGb2v641smXt4Pa8q_D5jc88GyN_3Y1-KdMzWbA91X_t62hZtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 4:32 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Sep 29, 2017 at 03:25:11AM +0000, Chen-Yu Tsai wrote:
>> The AXP81x family of PMIC is used with the Allwinner A83T and H8 SoCs.
>> This includes the AXP813 and AXP818. There is no discernible difference
>> except the labeling. The AXP813 is paired with the A83T, while the
>> AXP818 is paired with the H8.
>>
>> This patch adds a dtsi file for all the common bindings for these two
>> PMICs. Currently this is just listing all the regulator nodes. The
>> regulators are initialized based on their device node names.
>>
>> In the future this would be expanded to include power supplies and
>> GPIO controllers.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/axp81x.dtsi | 139 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 139 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/axp81x.dtsi
>>
>> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
>> new file mode 100644
>> index 000000000000..73b761f850c5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/axp81x.dtsi
>> @@ -0,0 +1,139 @@
>> +/*
>> + * Copyright 2017 Chen-Yu Tsai
>> + *
>> + * Chen-Yu Tsai <wens@csie.org>
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
>> +/* AXP813/818 Integrated Power Management Chip */
>> +
>> +&axp81x {
>> +     interrupt-controller;
>> +     #interrupt-cells = <1>;
>> +
>> +     regulators {
>> +             /* Default work frequency for buck regulators */
>> +             x-powers,dcdc-freq = <3000>;
>> +
>> +             reg_dcdc1: dcdc1 {
>> +             };
>
> Is there any reason not to add some default regulator names here?

The node names, and by extension, the drivers already provide default names.
regulator-name is not a required property either.

ChenYu
