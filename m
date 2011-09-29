From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Sep 2011 10:31:50 +0200
Subject: [PATCH] ARM: mm: Align bank start to MAX_ORDER_NR_PAGES
In-Reply-To: <1317198748-17705-1-git-send-email-johan.palsson@stericsson.com>
References: <1317198748-17705-1-git-send-email-johan.palsson@stericsson.com>
Message-ID: <CACRpkdbr_5uGOYgduDbzrf9214xo4Vnzaanfash-fF0T8Digew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 10:32 AM, Johan Palsson
<johan.palsson@stericsson.com> wrote:

> The VM subsystem assumes that there are valid memmap entries from
> the bank start aligned to MAX_ORDER_NR_PAGES.
>
> Cc: stable at kernel.org
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Michael Bohan <mbohan@codeaurora.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Johan Palsson <johan.palsson@stericsson.com>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I should mention that this is triggered a lot by our platform using
several disparate mem=n arguments on the command line,
chopping out pieces of memory here and there.

I will repost with a more descriptive message and then I'll
put it into the patch tracker, as it's a blocker already on 3.0
for us.

Yours,
Linus Walleij
