From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 29 Jul 2018 23:16:19 +0200
Subject: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
In-Reply-To: <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-8-jmkrzyszt@gmail.com>
 <20180719084447.239a1b92@bbrezillon>
 <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
Message-ID: <20180729231422.0264f971@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Jul 2018 22:36:49 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Jul 19, 2018 at 8:44 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > I guess you'd prefer to have the pin values in a bitmap instead of an
> > array of integers. That's probably something you can discuss with
> > Linus, see if he would accept to change the prototype of
> > gpiod_get_raw_array_value().  
> 
> I am not so smart as to see the overall effects but if what
> you're saying is that we shouldn't have designed these functions
> and callbacks using arrays of integers (or longs) and instead
> pass bitmaps, you may be just right. It intuitively sounds better.

Maybe, maybe not. Only an real evaluation of where the overhead is can
tell us. So I'd suggest trying to use the existing interface and doing
the int_array -> u8 conversion in the NAND driver first, and see how
much moving to a bitmap imprsoves things.

> But I'm not good with bitmaps.
> 
> We would have to refactor the world though.

I checked and, AFAICT, there are no external users of this API (only
core code is using those funcs, for ioctls I guess). Anyway, I think
we should wait for real numbers before we consider doing this change
(It's not unusual to get this sort of things wrong).
