From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 22 Sep 2015 16:07:03 +0200
Subject: [PATCH 1/3] irqchip: atmel-aic5: fix bug with mask/unmask
In-Reply-To: <alpine.DEB.2.11.1509221549420.5606@nanos>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
 <alpine.DEB.2.11.1509221226090.5606@nanos>
 <20150922135558.7be8ac1c@bbrezillon>
 <alpine.DEB.2.11.1509221549420.5606@nanos>
Message-ID: <20150922140703.GC28781@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 03:50:30PM +0200, Thomas Gleixner wrote:
> On Tue, 22 Sep 2015, Boris Brezillon wrote:
> > On Tue, 22 Sep 2015 12:27:08 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Why is this locking dgc->gc[0] and fiddling with some other generic
> > > chip?
> > 
> > Actually, we always access the same set of registers for all irqs of the
> > domain, and thus need to take the same lock (I chose the one contained
> > in the first generic irqchip, but I guess it could work with the others
> > too, as long as we always take the same one) before accessing them
> > because the configuration is done in two steps:
> > 
> > 1/ specify the irq line you want to configure
> > 2/ set the new configuration
> > 
> > Regarding register accesses, all generic chips are configured to
> > point to the same registers, so accessing them from the 'base' generic
> > chip or from the generic chip attached to the irq_data struct is the
> > same, though I agree that using bgc would add some consistency to the
> > implementation.
> 
> Fair enough. It just deserves a comment for the casual reader.
> 

Thanks for the addition of the comment.

Ludovic
