From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Aug 2012 10:51:45 +0100
Subject: [PATCH] ARM: ux500: resurrect I2C platform data
In-Reply-To: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
References: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120806095144.GA16996@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 10:52:26AM +0200, Linus Walleij wrote:
> Commit:
> 98582d9562b4bea6b0eb6e2bfafcd3fab3b60ccb
> "ARM: ux500: Remove unused i2c platform_data initialisation code"
> 
> Deleted platform data intialization code that was used,
> not unused as indicated in the commit. The boot log (without
> devicetree) now looks like this:

The aforementioned commit was part of a patch-set. One of its affiliates
moved this code into the Nomadik I2C driver; however, it was contested
because Device Tree support was also added and the maintainer thought 
the properties introduced could be consolidated with other I2C driver's
DT properties. I don't think anyone has taken up the consolidation work
and for that reason it hasn't gone in.

I think moving this stuff into the driver is the right thing to do.
Instead, I'll split out the configuration and DT enablement from the
patch and resubmit.

Sound good to you? 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
