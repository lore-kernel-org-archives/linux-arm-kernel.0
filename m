From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 21:38:19 +0200
Subject: [PATCH] memory: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqKLCWVY09RHgU71oc+QMa_bWg+t_yhb60iKFShFT41YPw@mail.gmail.com>
References: <20170718214339.7774-34-robh@kernel.org>
 <20170719054702.x6h2fkz6vplzyqg2@piout.net>
 <CAL_JsqKLCWVY09RHgU71oc+QMa_bWg+t_yhb60iKFShFT41YPw@mail.gmail.com>
Message-ID: <CAK8P3a1hr=x31+6U=xcM8W_6xhjjFPfP3-yk5C5tsK-KRMiP4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:22 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jul 19, 2017 at 12:47 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 18/07/2017 at 16:43:14 -0500, Rob Herring wrote:
>>> Now that we have a custom printf format specifier, convert users of
>>> full_name to use %pOF instead. This is preparation to remove storing
>>> of the full path string for each node.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-omap at vger.kernel.org
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> This can go through subsystem tree. Who normally takes drivers/memory/
> changes? arm-soc?

I applied it to next/drivers in arm-soc with the two acks now. For some
reason the whitespace change in omap-gpmc.c did not apply though,
so I ended up hand-editing the patch to take that out.

      Arnd
