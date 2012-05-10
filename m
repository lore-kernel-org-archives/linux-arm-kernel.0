From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 May 2012 15:57:12 +0000
Subject: [PATCH 02/12] pinctrl: basic Nomadik pinctrl interface
In-Reply-To: <201205101553.11304.arnd@arndb.de>
References: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdZ+8n-E_8nyq-kO=Y+GYekkjiNXd3nzTqFnxLszpuKKPg@mail.gmail.com>
 <201205101553.11304.arnd@arndb.de>
Message-ID: <201205101557.12902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, Arnd Bergmann wrote:
> > >
> > > Arnd, what is your preferred design pattern of:
> > >
> > > A) sub-drivers that register one struct platform_driver per
> > >  variant, then calls into a shared core driver, or
> > >
> > > B) a shared core driver registering one platform_driver
> > >  with several struct platform_device_id that then call
> > >  sub-drivers depending on which one is found
> > >
> > > Either way is actually OK for me, but I was thinking if one
> > > is preferred over the other.
> 
> Out of those two, I'd always pick B.
> 
> In cases where the variants are different enough that you want to
> put them into separate files, I'd do
> 
> C) Make the common code one module that just exports symbols but
> registers no platform_driver at all, then put each variant into
> its own module that binds to one ID and calls the exported
> functions from the common module.
> 

Sorry, I guess A and C are actually the same and I just misread the
question.

So I'd use A for things that are different enough to put them
into separate files, and B for things where I'd always build
all variants in the same driver module anyway, e.g. when only
a few parameters are different.

	Arnd
