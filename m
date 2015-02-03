From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 03 Feb 2015 13:48:41 +0300
Subject: [PATCH] ARM: shmobile: silk: initial device tree
In-Reply-To: <20150203003610.GA17629@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
 <20150202110557.GC7459@leverpostej> <54CFE4CE.5090406@cogentembedded.com>
 <20150203003610.GA17629@verge.net.au>
Message-ID: <54D0A789.5070707@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/3/2015 3:36 AM, Simon Horman wrote:

>>>> Add the initial device tree for the R8A7794 SoC based SILK low cost board.
>>>> SCIF2 serial port support is included, so that the serial console can work.

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> [...]

>>>> Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
>>>> @@ -0,0 +1,41 @@
>>>> +/*
>>>> + * Device Tree Source for the SILK board
>>>> + *
>>>> + * Copyright (C) 2014 Renesas Electronics Corporation
>>>> + * Copyright (C) 2014-2015 Renesas Solutions Corp.
>>>> + * Copyright (C) 2014-2015 Cogent Embedded, Inc.
>>>> + *
>>>> + * This file is licensed under the terms of the GNU General Public License
>>>> + * version 2.  This program is licensed "as is" without any warranty of any
>>>> + * kind, whether express or implied.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +#include "r8a7794.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "SILK";

>>> Shouldn't that have a "Renesas" prefix or something like that?

>>     Historically. no SH-Mobile .dts has used the vendor name in the "model"
>> prop. I defer the decision to Simon but I think we should be at least
>> consistent.

> They are also my thoughts (except the bit about deferring to myself).

> If there is a good motivation for a Renesas prefix then that is fine by me.
> But in that case it seems that it would be appropriate to update
> the existing renesas boards too.

> The only thing that stood out to me about "SILK" was that unlike
> other renesas boards names in .dtsi files it is all-capitals.
> Its not a bit deal but as we are on the topic: is that intentional?

    Yes, it is all uppercase. See e.g. http://www.elinux.org/R-Car/Boards/SILK.

WBR, Sergei
