From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Sep 2013 08:37:54 +0200
Subject: Inte IOP Xscale updates
In-Reply-To: <21035.952.938696.169280@pilspetsen.it.uu.se>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
 <20130903134516.GH6617@n2100.arm.linux.org.uk>
 <21035.952.938696.169280@pilspetsen.it.uu.se>
Message-ID: <CACRpkdY=GwPyJUDuFBtfb=E5VD8h0mqi9146vRm3XeVjH=F7Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 7, 2013 at 12:45 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:

> As long as they doesn't cause any maintenance problems I think we
> should just leave the IOP platforms as-is.

Well I looked over all machines last week and for IOP there is
one thing that stand out, and it's that iop32x and iop33x are
using <mach/gpio.h> and that is a headache for me as GPIO
maintainer, as I want to consolidate that subsystem and get
away from custom GPIO headers.

But I take it that you're ready to test patches for me, so
I'll hopefully get around to propose something for the
iop32x :-)

Basically I'd move <asm/hardware/iop3xx-gpio.h> down
into drivers/gpio as a gpiochip instead.

Yours,
Linus Walleij
