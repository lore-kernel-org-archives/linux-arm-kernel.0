From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 15:52:10 +0100
Subject: [PATCH 3/6] dma: coh901318_lli: avoid unbalanced locking
In-Reply-To: <1360666720-19006-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1360666720-19006-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1360666720-19006-4-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <CACRpkdZ=9pmutR2G+z5kQpjx2O6995OnDU8iN3cqar3TWoX=Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 11:58 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> I have not checked the code but there is a possibility that custom pool->lock
> is not needed at all due to dma_pool contains it's own lock.

Can you please change the description to something like:

"The coh901318_lli allocator releases a lock on the exit path without
taking it first".

Which is what the patch is actually fixing.

After that it's Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
