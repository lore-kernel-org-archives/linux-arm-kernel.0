From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 Jul 2014 15:46:56 -0700
Subject: [PATCHv4 3/5] common: dma-mapping: Introduce common remapping
 functions
In-Reply-To: <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAOesGMimCAYnqxkKoYpZ2ws7x9eH4K1Yw3LnLz9HC6MWyHEo3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 11:03 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
>
> For architectures without coherent DMA, memory for DMA may
> need to be remapped with coherent attributes. Factor out
> the the remapping code from arm and put it in a
> common location to reduced code duplication.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Hm. The switch from ioremap to map_vm_area() here seems to imply that
lib/ioremap can/should be reworked to use just wrap the vmalloc
functions too?

Unrelated to this change.

I did a pass of review here. Nothing stands out as wrong but I don't
claim to know this area well these days.

What's the merge/ack plan here? It might reduce the complexity of
merging to add the common functions in your series, then move the ARM
code over separately?


-Olof
