From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 27 Oct 2015 09:59:43 +0300
Subject: [PATCH 4/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <562F0795.10900@samsung.com>
References: <cover.1445859834.git.p.fedin@samsung.com>
 <7ac097efc649bac4e9f2b991baaa969ce4cbc3ef.1445859834.git.p.fedin@samsung.com>
 <562F0795.10900@samsung.com>
Message-ID: <00b101d11085$0f9f7be0$2ede73a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +Bank configurations can be defined as an optional subnodes. They can have the
> > +following properties:
> > +- bank : bank number (0 - 3)
> > +- width : data width in bytes (1 or 2). If omitted, default of 1 is used.
> > +- srom-timing : array of 7 integers: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs
> > +
> 
> I think these will be optional properties as all Exynos SoC may not be
> having these. So better to add them under "Optional Properties" heading,
> and move this above the "-Example" heading

 Not really. Actually 'bank' is not optional, because it actually identifies to which bank properties are applied, and srom-timings
are settings by themselves. Without both of them the definition just doesn't make sense. The only really optional specifier is
'width', which has a default.
 Could you give me an example of how to write this correctly?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
