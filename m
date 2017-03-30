From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 30 Mar 2017 11:47:32 -0500
Subject: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
In-Reply-To: <20170328144543.GA18046@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
Message-ID: <20170330164732.GA8437@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:45:43PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Mar 27, 2017 at 08:41:10PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 27, 2017 at 10:49:30AM +0100, Lorenzo Pieralisi wrote:

> > >  #define ioremap_uc ioremap_uc
> > > +#define ioremap_nopost ioremap_nocache
> > 
> > These are all the same as the default from asm-generic.h.  Do we really
> > need these definitions in alpha, avr32, frv, ia64, x86?
> 
> Those arches do not include asm-generic.h (I suppose for a good reason)

OK, that explains it.  I'm not at all sure there's a good reason for
those arches not using asm-generic.h, but I haven't looked at the code
to see.

> but a definition is needed anyway if we want code using ioremap_nopost()
> to be unconditional. This is one way of doing it, there are others not
> sure they are any better, I am open to suggestions.
