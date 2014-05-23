From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 14:58:54 +0200
Subject: [PATCH 04/10] irqchip: versatile-fpga: add DT init
In-Reply-To: <1400620176-7239-5-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-5-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbcwaLss=9M7FS47_tt8zzpnBCx5NN9a-f5C_c1vKBSuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Add IRQCHIP_DECLARE call for the versatile-fpga interrupt controller so
> that initialization from DT will work.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>

If the different compatible string indicated that the hardware
is different that string must be used to augment the runpath,
right?

It seems to me that the special routing register will be used
whenever the DT has this special passthrough property set,
but that should be *refused* on all other variants, as that
regiser has a different meaning on the integrator (used for
FIQ).

Yours,
Linus Walleij
