From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 1 Nov 2016 09:11:02 -0500
Subject: [PATCH v2] ARM: dts: socfpga: Add Macnica sodia board
In-Reply-To: <CAOesGMgkVWNZ0Nq0c-GZXbJETVBKOo2m5gZ1u8gUtb0tUDeqjQ@mail.gmail.com>
References: <20160924235945.32128-1-iwamatsu@nigauri.org>
 <CAOesGMgkVWNZ0Nq0c-GZXbJETVBKOo2m5gZ1u8gUtb0tUDeqjQ@mail.gmail.com>
Message-ID: <8ca09198-dfb8-0a2a-ed2b-d75577f13955@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


On 10/27/2016 07:23 PM, Olof Johansson wrote:
> Hi,
> 
> Saw this when looking at the patch when merging it.
> 
> Please fix up with incremental patch. Dinh, this goes for other
> platforms under socfpga too, several have this problem:
> 
> On Sat, Sep 24, 2016 at 4:59 PM, Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> new file mode 100644
>> index 0000000..9aaf413
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
>> @@ -0,0 +1,123 @@
>> +/*
>> + *  Copyright (C) 2016 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "socfpga_cyclone5.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +
>> +/ {
>> +       model = "Altera SOCFPGA Cyclone V SoC Macnica Sodia board";
>> +       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> 
> You should add a compatible entry for your specific board. Compatible
> goes from specific to generic, so something like:
> 
> compatible = "altr,macnica-sodia", "latr,socfpga-cyclone5", "altr,socfpga";
> 
> You can even add entries for the specific rev (if there are
> differences). But at the very least, add one for the board.
> 
> 
> Dinh, please follow up for other boards as well. I've still merged the
> pull request you sent (email about that separately).
> 

Thanks for noticing this. I'll send a patch to fix this shortly.

Dinh
