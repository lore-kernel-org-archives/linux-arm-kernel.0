From: albeu@free.fr (Alban)
Date: Sun, 19 Aug 2018 13:31:06 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <20180817182720.6a6e5e8e@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon>
Message-ID: <20180819133106.0420df5f@tock>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Aug 2018 18:27:20 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Bartosz,
> 
> On Fri, 10 Aug 2018 10:05:03 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Alban Bedel <albeu@free.fr>
> > 
> > Allow drivers that use the nvmem API to read data stored on MTD devices.
> > For this the mtd devices are registered as read-only NVMEM providers.
> > 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > [Bartosz:
> >   - use the managed variant of nvmem_register(),
> >   - set the nvmem name]
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>  
> 
> What happened to the 2 other patches of Alban's series? I'd really
> like the DT case to be handled/agreed on in the same patchset, but
> IIRC, Alban and Srinivas disagreed on how this should be represented.
> I hope this time we'll come to an agreement, because the MTD <-> NVMEM
> glue has been floating around for quite some time...

These other patches were to fix what I consider a fundamental flaw in
the generic NVMEM bindings, however we couldn't agree on this point.
Bartosz later contacted me to take over this series and I suggested to
just change the MTD NVMEM binding to use a compatible string on the
NVMEM cells as an alternative solution to fix the clash with the old
style MTD partition.

However all this has no impact on the code needed to add NVMEM support
to MTD, so the above patch didn't change at all.

Alban
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180819/e814be0d/attachment.sig>
