From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Jan 2015 19:50:33 +0000
Subject: [PATCH v2 1/2] of/pci: add of_pci_dma_configure() update dma
 configuration
In-Reply-To: <54A71CD1.4070107@ti.com>
References: <1419459099-6667-1-git-send-email-m-karicheri2@ti.com>
 <1419459099-6667-2-git-send-email-m-karicheri2@ti.com>
 <CAL_JsqJtVnP_5zAiUvMwL00JQV0mjw-R_hEkxiv13ZuNrQ8nAA@mail.gmail.com>
 <54A6D375.6050604@ti.com>
 <CAL_Jsq+krOUA3BPvMCdaOBhALoi+pzWbw3YndXqR8x52OJogZg@mail.gmail.com>
 <54A71CD1.4070107@ti.com>
Message-ID: <20150106195033.GH32449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 02, 2015 at 10:33:53PM +0000, Murali Karicheri wrote:
> On 01/02/2015 03:45 PM, Rob Herring wrote:
> > On Fri, Jan 2, 2015 at 11:20 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
> >> On 12/26/2014 02:33 PM, Rob Herring wrote:
> >>> On Wed, Dec 24, 2014 at 4:11 PM, Murali Karicheri<m-karicheri2@ti.com>
> >>>> +               coherent = of_dma_is_coherent(parent_np);
> >>>> +               dev_dbg(dev, "device is%sdma coherent\n",
> >>>> +                       coherent ? " " : " not ");
> >>>> +
> >>>> +               arch_setup_dma_ops(dev, dma_addr, size, NULL, coherent);
> >>>
> >>>
> >>> This is the same code as of_dma_configure. The only difference I see
> >>> is which node ptr is passed to of_dma_get_range. You need to make that
> >>> a function param of of_dma_configure.
> >>>
> >>> of_dma_configure also has iommu handling now. You will probably need
> >>> something similar for PCI in that you setup an iommu based on the root
> >>> bus DT properties.
> >>>
> >> Initially I had the same idea to re-use the existing function
> >> of_dma_configure() for this. I wanted to defer this until we have an
> >> agreement on the changes required for the subject functionality. My quick
> >> review of the code suggestio this would require additional API changes as
> >> below. I did a quick test of the changes and it works for Keystone, but need
> >> to be reviewed by everyone as I touch the IOMMU functionality here and I
> >> don't have a platform with IOMMU. Need test by someone to make sure I don't
> >> break anything.
> >
> > The IOMMU changes look trivial. We may want to address the comment in
> > of_iommu_configure about parent nodes. We should be sure these changes
> > work with how we would do searching parent nodes.
> 
> I have no experience with IOMMU and may not offer much help here as I 
> originally wrote above. Will Deacon has added this API and probably able 
> to offer some help in this discussion.
> 
> Will Deacon,
> 
> Any comment?

Sorry for the delay; I'm still catching up on email after the Christmas
break, but I *will* get around to looking at this. If you have a new version
to post based on the comments from Rob and Arnd, feel free to send that and
I'll look at that instead.

Will
