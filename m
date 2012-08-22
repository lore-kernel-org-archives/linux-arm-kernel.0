From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2012 11:21:32 +0200
Subject: [rtc-linux] [PATCHv3 8/9] arm: vt8500: gpio: Devicetree support
 for arch-vt8500
In-Reply-To: <1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdZnQyLSRQ6cRpFBurAv2cv44einGAsT86FLCqsj1euDMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 10:47 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Converted the existing arch-vt8500 gpio to a platform_device.
> Added support for WM8505 and WM8650 GPIO controllers.
(...)
> +       unsigned val;

I asked about the datatype for this "val", it sure isn't "unsigned".

I suspected the registers were only 8bit and so it should be u8.
But atleast use u32 if you must use all these bits.

(...)
> +       val = readl(vt8500_chip->base + vt8500_chip->regs->en);
> +       val |= BIT(offset);
> +       writel(val, vt8500_chip->base + vt8500_chip->regs->en);

BTW: have you considered [readl|writel]_relaxed?

Yours,
Linus Walleij
