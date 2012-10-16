From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 16 Oct 2012 09:16:17 +0200
Subject: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
Message-ID: <CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 12 October 2012 23:32, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 12, 2012 at 5:33 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The cookie is now used to indicate if dma_unmap_sg shall be
>> done in post_request. At DMA errors, the DMA job is immediately
>> not only terminated but also unmapped. To indicate that this
>> has been done the cookie is reset to zero. post_request will
>> thus only do dma_umap_sg for requests which has a cookie not set
>> to zero.
>>
>> Some corresponding duplicated code could then be removed and
>> moreover some corrections at DMA errors for terminating the same
>> DMA job twice has also been fixed.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>
> It looks like it's both factoring out code and also adding some unmapping
> in hithereto unhandled cases, correct? It looks OK to me now atleast so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This code has not been tested on a "legacy" ARM PL180 but only for
ux500 boards. Even if it should affect DMA handling we should test
this properly. Would be great if you were able to help out, I guess
you still have available hardware for these tests?

Kind regards
Ulf Hansson
