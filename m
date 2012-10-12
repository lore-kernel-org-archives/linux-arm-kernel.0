From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 23:32:31 +0200
Subject: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 5:33 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The cookie is now used to indicate if dma_unmap_sg shall be
> done in post_request. At DMA errors, the DMA job is immediately
> not only terminated but also unmapped. To indicate that this
> has been done the cookie is reset to zero. post_request will
> thus only do dma_umap_sg for requests which has a cookie not set
> to zero.
>
> Some corresponding duplicated code could then be removed and
> moreover some corrections at DMA errors for terminating the same
> DMA job twice has also been fixed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

It looks like it's both factoring out code and also adding some unmapping
in hithereto unhandled cases, correct? It looks OK to me now atleast so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
