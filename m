From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 29 Aug 2018 10:27:09 +0200
Subject: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
In-Reply-To: <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFore4GkGyMn-4VA-2h1MbNp9sQ0Szif+Mjj5qtM-7autw@mail.gmail.com>
Message-ID: <20180829082708.2li4opnruodugo36@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 12:43:31PM +0200, Ulf Hansson wrote:
> On 23 August 2018 at 06:44, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Add UniPhier SD/eMMC controller support.
> >
> > As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> > The clock rate setting is platform-specific, and UniPhier variants
> > will add another way.  I thought it would be better to split this
> > to a hook to avoid a mess.
> >
> > V3 is rebase on top of Linus' tree.
> 
> I have queued patch 1 -> 4, waiting for further reviews for patch 5 and 6.

I have re-tested patches 1-4 as applied to mmc/next and it all works
fine. For those

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Now, going to check patches 5+6...

> > I dropped 6/7 because Renesas added more quirks
> > in the current MW.

Totally fine. We need to cleanup HS400 support more, then we can try the
simplification you did for tmio_mmc.c, too. Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/4c9865dc/attachment.sig>
