From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Nov 2016 23:27:06 +0100
Subject: [PATCH] pinctrl: sunxi: make bool drivers explicitly non-modular
In-Reply-To: <20161030000030.9394-1-paul.gortmaker@windriver.com>
References: <20161030000030.9394-1-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdbDk33ffD=S39KjgPh6bcY6QrjCs6gpyC6TherO4kv-4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 2:00 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> None of the Kconfigs for any of these drivers are tristate,
> meaning that they currently are not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the drivers there is no doubt they are builtin-only.  All
> drivers get essentially the same change, so they are handled in batch.
>
> Changes are (1) use builtin_platform_driver, (2) use init.h header
> (3) delete module_exit related code, (4) delete MODULE_DEVICE_TABLE,
> and (5) delete MODULE_LICENCE/MODULE_AUTHOR and associated tags.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We do delete the MODULE_LICENSE etc. tags since all that information
> is already contained at the top of each file in the comments.
>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Cc: Fabian Frederick <fabf@skynet.be>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Vishnu Patekar <vishnupatekar0510@gmail.com>
> Cc: Mylene Josserand <mylene.josserand@free-electrons.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
