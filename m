From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2018 23:22:22 +0200
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
In-Reply-To: <20180629185107.GA37488@beast>
References: <20180629185107.GA37488@beast>
Message-ID: <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 8:51 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a pre-allocated scratch register space, set up with
> all other other allocations.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: dmaengine at vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I looked too long at this one, in short:

- Your change looks correct to me
- It could be done better in many ways, all of which would
  involve cleaning up some of the existing code in the process
- Nobody uses this driver in practice, as the hardware platform
  was a dead end

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
