From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:36:49 +0200
Subject: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
In-Reply-To: <20180719084447.239a1b92@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-8-jmkrzyszt@gmail.com>
 <20180719084447.239a1b92@bbrezillon>
Message-ID: <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 8:44 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> I guess you'd prefer to have the pin values in a bitmap instead of an
> array of integers. That's probably something you can discuss with
> Linus, see if he would accept to change the prototype of
> gpiod_get_raw_array_value().

I am not so smart as to see the overall effects but if what
you're saying is that we shouldn't have designed these functions
and callbacks using arrays of integers (or longs) and instead
pass bitmaps, you may be just right. It intuitively sounds better.
But I'm not good with bitmaps.

We would have to refactor the world though.

Yours,
Linus Walleij
