From: rabin@rab.in (Rabin Vincent)
Date: Mon, 17 Jan 2011 20:29:53 +0530
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTin+-0YJKSNhZX5JW0W8Nayy==BTqBig2ORs8xo7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 18:34, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> + ? ? ? {
> + ? ? ? ? ? ? ? .dev_name = "bh1780",
> + ? ? ? ? ? ? ? .supply = "v-als",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .dev_name = "lsm303dlh.0",
> + ? ? ? ? ? ? ? .supply = "v-accel",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .dev_name = "lsm303dlh.1",
> + ? ? ? ? ? ? ? .supply = "v-mag",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .dev_name = "bu21013_ts.0",
> + ? ? ? ? ? ? ? .supply = "v-touch",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .dev_name = "bu21013_ts.1",
> + ? ? ? ? ? ? ? .supply = "v-touch",
> + ? ? ? },

These device names are all wrong; they need to use the i2c client dev
names.  And the recent patches for regulator support in the bu driver
use a different supply name.

Also, there's a macro to make this list more compact:
REGULATOR_SUPPLY().
