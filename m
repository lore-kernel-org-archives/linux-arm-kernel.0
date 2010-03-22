From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Mar 2010 10:36:27 +0800
Subject: [PATCH] locomo.c: spi register offset bugfix
In-Reply-To: <0D753D10438DA54287A00B027084269763683A71C0@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269763683A71C0@AUSP01VMBX24.collaborationhost.net>
Message-ID: <f17812d71003211936m33d39380l2b5c2638015b295e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 1:11 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> The locomo spi registers are all defined in locomo.h as offsets
> from the first spi register LOCOMO_SPI (0x60), which is itself
> an offset from the locomo base address. ?To correctly access
> these registers LOCOMO_SPI must always be included in the
> address calculation.
>
> There are two places in locomo.c where this is not done. ?The
> first one, in locomo_suspend, actually results in a write to
> LOCOMO_ST instead of LOCOMO_SPICT. ?The second is in __locomo_probe
> and results in a write to LOCOMO_MCSX2 instead of LOCOMO_SPIIE.
>
> Fix these by including LOCOMO_SPI in the calculation.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
>

Applied to 'fix'.
