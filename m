From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 09:03:04 +0100
Subject: [PATCH v3 1/3] gpio: pca953x: make the register access by GPIO
 bank
In-Reply-To: <1358889025-8530-2-git-send-email-gregory.clement@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZcTbwNPEnSeCGxxWbZHwayair-s50DWYy1EqpGLNvVZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:10 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Until now the pca953x driver accessed all the bank of a given register
> in a single command using only a 32 bits variable. New expanders from
> the pca53x family come with 40 GPIOs which no more fit in a 32
> variable. This patch make access to the registers more generic by
> relying on an array of u8 variables. This fits exactly the way the
> registers are represented in the hardware.
>
> It also adds helpers to access to a single register of a bank instead
> of reading or writing all the banks for a given register.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This is a nice refactoring and tested too, so patch applied.

I have some nitpicks, may try to fix them with a follow-up
patch but it's certainly not super-important stuff.

Yours,
Linus Walleij
