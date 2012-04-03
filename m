From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 08:19:48 +0000
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
 <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
Message-ID: <201204030819.48798.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Fabio Estevam wrote:
> On Mon, Apr 2, 2012 at 10:01 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> 
> > I see.  Well, there weren't any follow ups to it but I would say that
> > passing both sys->resources and sys both side-by-side at the same
> > time doesn't really make sense.  I think just passing in sys by itself
> > as I did is a cleaner way to go, wouldn't you agree?
> 
> Yes, I agree.

But that doesn't work: struct pci_sys_data is ARM specific, while
pci_add_resource_offset is common code.

I think it would be much more sensible here to just use pci_add_resource(),
which is the same as the offsets are all zero for versatile.

	Arnd
