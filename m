From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 12:54:20 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <201403171229.39021.arnd@arndb.de>
References: <20140317105448.14bcb617@marrow.netinsight.se>
 <20140317105659.449505d8@marrow.netinsight.se>
 <201403171229.39021.arnd@arndb.de>
Message-ID: <20140317125420.375b5726@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Mar 2014 12:29:38 +0100
Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> > -int dma_set_coherent_mask(struct device *dev, u64 mask)
> > -{
> > -       if (mask >= SZ_64M - 1)
> > -               return 0;
> > -
> > -       return -EIO;
> > -}
> > -
> >  EXPORT_SYMBOL(ixp4xx_pci_read);
> >  EXPORT_SYMBOL(ixp4xx_pci_write);
> >  EXPORT_SYMBOL(dma_set_coherent_mask);
> 
> When you move this function, you should really move the
> 'EXPORT_SYMBOL' along with it.

Yes, you are right. Will fix and resend the patches!

// Simon
