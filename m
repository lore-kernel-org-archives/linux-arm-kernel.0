From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 20:43:56 +0100
Subject: [PATCH] ARM: ux500: solve some Kconfig mess
In-Reply-To: <201202291928.49516.arnd@arndb.de>
References: <1330536509-13590-1-git-send-email-linus.walleij@stericsson.com>
 <201202291928.49516.arnd@arndb.de>
Message-ID: <CACRpkdaqdmB0_Z9FYC97FWZ2+RBSMfErUa62y0icqSOqAo8o1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 8:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Looks good to me. One thing I still wonder about is whether
> we should leave the UX500_SOC_DB5500 and UX500_SOC_DB8500
> options user-visible. It would probably be simpler to just
> select these whenever a board using them is enabled.

They are invisible to me atleast?

config UX500_SOC_DB5500
        bool
        select MFD_DB5500_PRCMU

config UX500_SOC_DB8500
        bool
        select MFD_DB8500_PRCMU
        select REGULATOR_DB8500_PRCMU
        select CPU_FREQ_TABLE if CPU_FREQ


Yours,
Linus Walleij
