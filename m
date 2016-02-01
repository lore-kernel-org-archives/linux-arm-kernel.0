From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Feb 2016 12:11:12 +0000
Subject: [PATCHv2 1/3] arm64: Drop alloc function from create_mapping
In-Reply-To: <CAKv+Gu-VTg6m9PNRCEDm07nwku3YVmYkMSs-08p_SigqOdabhQ@mail.gmail.com>
References: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
 <1454111218-3461-2-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu-VTg6m9PNRCEDm07nwku3YVmYkMSs-08p_SigqOdabhQ@mail.gmail.com>
Message-ID: <20160201121111.GE674@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2016 at 11:34:50AM +0100, Ard Biesheuvel wrote:
> On 30 January 2016 at 00:46, Laura Abbott <labbott@fedoraproject.org> wrote:
> >
> > create_mapping is only used in fixmap_remap_fdt. All the create_mapping
> > calls need to happen on existing translation table pages without
> > additional allocations. Rather than have an alloc function be called
> > and fail, just set it to NULL and catch it's use. Also change
> 
> s/it's/its/
> 
> > the name to create_mapping_noalloc to better capture what exactly is
> > going on.
> >
> > Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> 
> With one nit below:
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[...]

> > +/*
> > + * This function is for mapping using existing sections only.
> 
> Could you improve this comment? 'existing sections' does not quite
> cover what we expect to deal with imo
> > + */
> > +static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
> >                                   phys_addr_t size, pgprot_t prot)

Perhaps:

/*
 * This function can only be used to modify existing table entries,
 * without allocating new levels of table. Note that this permits the
 * creation of new section or page entries.
 */

Either way:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for putting this together!

Mark.
