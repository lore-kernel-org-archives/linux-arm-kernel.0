From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 13:51:56 +0100
Subject: [PATCH] staging: ste_rmi4: avoid unused function warnings
In-Reply-To: <4938658.kvPtQAFlP6@wuerfel>
References: <4938658.kvPtQAFlP6@wuerfel>
Message-ID: <CACRpkdZra=A_axSueevK8On+abwtAdO5B2-C_94D2p3qjDykuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The rmi4 touchscreen driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
>
> ste_rmi4/synaptics_i2c_rmi4.c:1050:12: warning: 'synaptics_rmi4_suspend' defined but not used
> ste_rmi4/synaptics_i2c_rmi4.c:1084:12: warning: 'synaptics_rmi4_resume' defined but not used
>
> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
