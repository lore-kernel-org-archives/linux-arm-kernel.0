From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 6 Dec 2011 07:13:21 +0100
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111205184522.316598de@lxorguk.ukuu.org.uk>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205184522.316598de@lxorguk.ukuu.org.uk>
Message-ID: <20111206061321.GH9192@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:45 Mon 05 Dec     , Alan Cox wrote:
> > But as you illustrated, there is a large number of drivers that already 
> > assume no IRQ is < 0, even if they don't use any IRQ #0 themselves.  
> > That is a much bigger problem to fix.
> 
> And a much larger number assuming the reverse is true which are hiding
> potential bugs on ARM.
> 
> Looking at the serial stuff the best checks appear to be looking at
> "irq", "-1" and NO_IRQ.
> 
> For migration stuff that's doing broken things like
> 
> 	if (irq < 0)
> 
> can be changed to
> 
> 	if (irq <= 0)
> 
> and that can be done before NO_IRQ itself is nailed on ARM and PA-RISC.
can we sinply introduce a macro irq_is_valid

and make it chip dependant as gpio_is_valid
and then move away from irq 0 valid

so we do not need to brake anthing first and then easly convert them

Best Regards,
J.
