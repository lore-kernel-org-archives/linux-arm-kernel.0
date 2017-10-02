From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Oct 2017 03:05:22 +0200
Subject: [PATCH 1/7] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
Message-ID: <CACRpkdZ=BZHp3mjccUYaPTuMbXgwGSErvLprnp4j0H+7C5NYJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
(...)
> SM501 users: requesting Tested-by on this patch.

Paging Simtec (if it reaches anyone), Vincent Sanders,
Teddy Wang at Silicon Motion:

Does any of you have an "Anubis" board so you can test GPIO
on this board before/after this patch and see if it checks out right?

I guess it's this board:
http://www.simtec.co.uk/products/BBD20EUROA/

Does anyone know of a commercially obtainable product using
SM501 with reasonable mainline Linux support so I can test it myself?

Getting a bit desperate...

Yours,
Linus Walleij
