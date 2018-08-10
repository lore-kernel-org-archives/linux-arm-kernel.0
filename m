From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2018 12:11:19 +0200
Subject: [RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port
 GPIO resource
In-Reply-To: <20180806222918.12644-5-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-5-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdZFq3AfH6ehCzMYqwptyfpdd3NLurx3kgj==DmKRASuiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Data port used by the driver is actually an OMAP MPUIO device, already
> under control of gpio-omap driver.  For that reason we used to not
> request the memory region of the port as that would fail because the
> region is already busy.  Despite that, we are still accessing the port
> by just ioremapping it and performing read/write operations.  Moreover,
> we are doing that without any proteciton from other users legally
> manipulating the port pins over GPIO API.
>
> The plan is to convert the driver to access the port over functions
> exposed by the gpio-omap driver.  Before that happens, already prevent
> from other users accessing the port pins by requesting an array of its
> GPIO descriptors.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
