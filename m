From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Mar 2016 11:45:20 +0700
Subject: [PATCH 3/7 v2] video: ARM CLCD: support DT signal inversion flags
In-Reply-To: <56D02A3A.6010701@ti.com>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-4-git-send-email-linus.walleij@linaro.org>
 <56D02A3A.6010701@ti.com>
Message-ID: <CACRpkdbeY5+Rsiomf66PQ2R=62BvMAW-QjYHUx-x9NgJT35StQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:34 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>> +     /* Set up some inversion flags */
>> +     timnp = of_get_child_by_name(node, "panel-timing");
>> +     if (timnp && of_property_read_bool(timnp, "pixelclk-active")) {
>
> Hmm, why are you poking in the videomode DT properties directly?

It is to provide
backward compatibility with already deployed device trees that
do not have this property set, so that they default to negative edge
rather than positive edge.

> If the
> pixelclk-active was not defined in the DT, you should see it in the
> videomode struct as neither DISPLAY_FLAGS_PIXDATA_POSEDGE nor
> DISPLAY_FLAGS_PIXDATA_NEGEDGE being set (I think, I didn't go through
> the code in detail).

OK I'll take a look!

Yours,
Linus Walleij
