From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 20:05:44 +0100
Subject: [PATCH] pwm: Call pwm_enable() before pwm_config()
In-Reply-To: <20120823190402.GA8127@avionic-0098.mockup.avionic-design.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de> <50366628.5020007@metafoo.de>
 <20120823190402.GA8127@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120920190544.GB13264@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 09:04:02PM +0200, Thierry Reding wrote:

> Using runtime PM for this sounds indeed like the most generic approach.
> I'm not very familiar with the API, but I thought it required explicit
> architecture or bus support (or the driver itself can provide hooks via
> pm_ops), so it might be difficult to implement for platforms that don't
> have working runtime PM support. I'll have to look into this some more.

It doesn't require explicit arch support, though many architectures
choose to integrate their PM frameworks with it either directly or via
power domains.  If the architecture doesn't do anything with it then it
should just work at the driver level.
