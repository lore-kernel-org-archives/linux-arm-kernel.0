From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Aug 2018 10:32:53 +0800
Subject: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
Message-ID: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> > Hello
> >
> > This patchset add support for allwinner R40 AHCI controller.
> >
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> >
> > The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> > but will be resent for inclustion when all patchs will have hit linus
> > tree.
>
> Applied 1-12 with Hans's blessing, thanks Corentin.

Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
merge them through the sunxi / armsoc tree. Having them in separate trees
introduces conflicts when we have other stuff going through our tree.

Corentin, it's best to lay out the plan to get patches merges in the cover
letter, specifically which maintainer should take which patches, or if an
immutable tag/branch is preferred, when things can't be separated cleanly.
This helps other subsystem maintainers that don't routinely deal with armsoc.

Also, we probably can't merge the last patch that removes the PHY code,
since we have to support old device trees.

Thanks
ChenYu
