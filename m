From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Jun 2014 09:44:28 +0200
Subject: [PATCH v2 1/6] ARM: mm: cache-l2x0: Add base address argument to
 write_sec callback
In-Reply-To: <1403703451-12233-2-git-send-email-t.figa@samsung.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
 <1403703451-12233-2-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdaA2oDOTBcL=S2j5bUTSB7oaS8ZWN0Rnf9Pbwtf3fTKjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 3:37 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> For certain platforms (e.g. Exynos) it is necessary to read back some
> values from registers before they can be written (i.e. SMC calls that
> set multiple registers per call), so base address of L2C controller is
> needed for .write_sec operation. This patch adds base argument to
> .write_sec callback so that its implementation can also access registers
> directly.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

>  arch/arm/mach-ux500/cache-l2x0.c   | 3 ++-

In our case just changing the signature of the function I see so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
