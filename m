From: masami.hiramatsu@linaro.org (Masami Hiramatsu)
Date: Mon, 11 Dec 2017 22:34:17 +0900
Subject: [PATCH net-next v5 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <20171211210455.170A.4A936039@socionext.com>
References: <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
 <CAOFm3uELNTgenR91-QGL1QQ08zA0N0rQbH4hzCzFKtRw6TckLw@mail.gmail.com>
 <20171211210455.170A.4A936039@socionext.com>
Message-ID: <CAA93ih2i+G2uyL8O-4F1juR1DpUYCd1U1dBCRRM5Xdd3L-m95g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2017-12-11 21:04 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> On Mon, 11 Dec 2017 10:19:15 +0100 Phlippe Ombredanne <pombredanne@nexb.com> wrote:
>
>> Dear Kunihiko-san,
>>
>> On Mon, Dec 11, 2017 at 8:57 AM, Kunihiko Hayashi
>> <hayashi.kunihiko@socionext.com> wrote:
>> > The UniPhier platform from Socionext provides the AVE ethernet
>> > controller that includes MAC and MDIO bus supporting RGMII/RMII
>> > modes. The controller is named AVE.
>> >
>> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> [...]
>> > --- /dev/null
>> > +++ b/drivers/net/ethernet/socionext/Makefile
>> > @@ -0,0 +1,5 @@
>> > +# SPDX-License-Identifier: GPL-2.0
>>
>> You are correctly using SPDX ids here....
>>
>> > +obj-$(CONFIG_SNI_AVE) += sni_ave.o
>> > diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
>> > new file mode 100644
>> > index 0000000..7b293c2
>> > --- /dev/null
>> > +++ b/drivers/net/ethernet/socionext/sni_ave.c
>> > @@ -0,0 +1,1744 @@
>> > +/**
>> > + * sni_ave.c - Socionext UniPhier AVE ethernet driver
>> > + *
>> > + * Copyright 2014 Panasonic Corporation
>> > + * Copyright 2015-2017 Socionext Inc.
>> > + *
>> > + * This program is free software: you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2  of
>> > + * the License as published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>>
>> ... then I guess you could also use them here, replacing at least 7
>> lines of boilerplate by a single id line?
>>
>> > +// SDPX-License-Identifier: GPL-2.0
>
> Thank you for your kindly comment.
>
> It seems there are few ethernet drivers applying SPDX-License-Identifier
> to C source, then it has been difficult for me to decide whether to replace
> boilerplate.
>
> If it's no problem to apply SPDX to sources of ethernet drivers,
> I'll replace it with the single line.
>
>> And if you go C++ style all the way, this could be even more compact:
>>
>> > +// SDPX-License-Identifier: GPL-2.0
>> > +// sni_ave.c - Socionext UniPhier AVE ethernet driver
>> > +// Copyright 2014 Panasonic Corporation
>> > +// Copyright 2015-2017 Socionext Inc.
>
> It's much simpler.
> If it's reasonable to apply this style here, I can replace it, too.

IMHO, even if we use SPDX license identifier, I recommend to use
C-style comments as many other files do, since it is C code.
If SPDX identifier requires C++ style, that is SPDX parser's issue
and should be fixed to get it from C-style comment.

https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf

Anyway, SPDX.org itself shows C-style (short header) example. See page 6.

Thank you,

>
> Thank you,
>
> ---
> Best Regards,
> Kunihiko Hayashi
>
>



-- 
Masami Hiramatsu
