From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Mon, 19 Mar 2012 09:51:32 +0100
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <20120318054329.GA29638@S2101-09.ap.freescale.net>
References: <1331919483.31118.23.camel@flow>
 <20120318054329.GA29638@S2101-09.ap.freescale.net>
Message-ID: <CA+gwMcfcoQEcP4wsnkoy3djoUyih=J+wN-HFKV7ng-zhsaoR9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2012 at 6:43 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Your patch #2 is trying to avoid the layering violation by separating
> static clock definitions and from clk_ops implementations into
> different files. ?But ...
>
> On Fri, Mar 16, 2012 at 06:38:03PM +0100, Philipp Zabel wrote:
> ...
>> diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
>> index a3585a2..7c04f9b 100644
>> --- a/arch/arm/mach-pxa/clock.h
>> +++ b/arch/arm/mach-pxa/clock.h
>> @@ -1,80 +1,106 @@
>> ?#include <linux/clkdev.h>
>> +#include <linux/clk-private.h>
>
> ... This is what I read from clk-private.h.

Thank you.
I could just remove that include line from clock.h, because it is only
needed for the static clock definition macros.
The pxa[23]?x.c, where they are used, already #include <clk-private.h> directly.
Or, to do it properly, clock.h could also be split in two.

regards
Philipp
