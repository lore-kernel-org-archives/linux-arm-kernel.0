From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 1 Dec 2017 09:41:22 +0100
Subject: [PATCH RFC 2/2] arm64: allwinner: a64: Add Brava Keller initial
 support
In-Reply-To: <20171201075421.33pgum4jjcvjxuju@flea.lan>
References: <1512067334-12761-1-git-send-email-jagan@amarulasolutions.com>
 <1512067334-12761-2-git-send-email-jagan@amarulasolutions.com>
 <20171201075421.33pgum4jjcvjxuju@flea.lan>
Message-ID: <CAOFm3uE_nrPP1Ce60occjSWodC9tpx2WDB8TarChcqBhq7Y9=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jagan,

On Fri, Dec 1, 2017 at 8:54 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Dec 01, 2017 at 12:12:14AM +0530, Jagan Teki wrote:
[]
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-brava-keller.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-brava-keller.dts
>> new file mode 100644
>> index 0000000..f5303a3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-brava-keller.dts
>> @@ -0,0 +1,244 @@
>> +/*
>> + * Copyright (C) 2017 Jagan Teki <jagan@amarulasolutions.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
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

Have you considered replacing this fine licensing boilerplate by the
new concise and cleaner SPDX ids?
Could it make sense, especially for new files, to avoid adding
boilerplate that will need to be cleaned up later?
You could get rid of these 37 lines and use this shorthand instead,
using the new conventions started by greg-kh and documented by tglx?

>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +// Copyright (c) 2017 Jagan Teki <jagan@amarulasolutions.com>


Thomas has sent a first doc patch [1] set and is working on an updated
version.  Jonathan also wrote a nice background article on the topic
at LWN [2].

And as a bonus, this device tree addition of yours minus this
boilerplate could save a few real trees if someone ever prints --god
forbid-- this file, so you would be making a good thing for the
planet! And consider too the energy savings from not having these
extra bytes transferred million of times and not retrieved from disks
spindles.

[1] https://marc.info/?l=linux-kernel&m=151051532322831&w=2
[2] https://lwn.net/SubscriberLink/739183/262749cbe307ddc7/
-- 
Cordially
Philippe Ombredanne
