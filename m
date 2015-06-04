From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Jun 2015 10:22:37 +0200
Subject: [RFC] pinctrl: pinctrl-imx: implement suspend/resume
In-Reply-To: <1433171567-24571-1-git-send-email-stefan@agner.ch>
References: <1433171567-24571-1-git-send-email-stefan@agner.ch>
Message-ID: <CACRpkdaR3B8_Bbo+bBy=ZyDaNMc2OwWftZ5YL9PiH9gYwYS6Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 5:12 PM, Stefan Agner <stefan@agner.ch> wrote:

> In some SoC's using the IMX pin controller, the IP looses its state
> when entering lowest power modes. Enhance the driver with suspend/
> resume functions restoring the pin states.

(...)

This is weird:

> +       for (i = 0; i < info->ninput_regs; i++)
> +               writel(ipctl->input_regs[i], ipctl->base +
> +                               info->input_regs_offset + i * sizeof(u32 *));

sizeof(u32 *)?

Don't you mean sizeof(u32).

sizeof(u32 *) will be 4 bytes on a 32bit system, 8 bytes on a
64bit system ... but I think your registers are always
32 bits, 4 bytes, apart.

Yours,
Linus Walleij
