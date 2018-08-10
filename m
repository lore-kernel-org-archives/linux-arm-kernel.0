From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2018 12:10:41 +0200
Subject: [RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup
 table for NAND data port
In-Reply-To: <20180806222918.12644-4-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-4-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdaeVRy9XDptCZcTHLo7gs55uQx=6A9HnoQgRP-qnBCqUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
> device, already under control of gpio-omap driver.  The NAND driver
> gets access to the port by ioremapping it and performs read/write
> operations.  That is done without any proteciton from other users
> legally manipulating the port pins over GPIO API.
>
> The plan is to convert the driver to access the port over GPIO consumer
> API.  Before that is implemented, the driver can already obtain
> exclusive access to the port by requesting an array of its GPIO
> descriptors.
>
> Add respective entries to the NAND GPIO lookup table.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
