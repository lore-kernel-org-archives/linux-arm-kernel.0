From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 10 Sep 2012 20:19:18 +0100
Subject: [PATCH 08/14] tty/serial/kgdboc: Add and wire up clear_irqs
 callback
In-Reply-To: <20120910175704.GA11392@lizard>
References: <20120910040802.GA1261@lizard> <20120910041357.GH29537@lizard>
 <20120910121624.226c1a88@pyramind.ukuu.org.uk>
 <20120910175704.GA11392@lizard>
Message-ID: <20120910201918.1e3c8fd0@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Sep 2012 10:57:04 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> On Mon, Sep 10, 2012 at 12:16:24PM +0100, Alan Cox wrote:
> > > serial port, the CPU receives NMI exception, and we fall into KDB
> > > shell.  So, it is our "debug console", and it is able to interrupt
> > > (and thus debug) even IRQ handlers themselves.
> > 
> > You seem to have an assumption of single core here. What happens if
> > the NMI hits CPU #0 and the serial IRQ hits CPU #1 simultaneously ?
> 
> If you can't redirect all serial IRQs to NMI context, e.g. sometimes you get
> NMIs, sometimes IRQs, then your NMI handling is not deterministic, and surely
> this is not supported.

This seems like arch specific magic leaking into the tty code. Surely
this should be buried in the depths of the platform IRQ code ?

Alan
