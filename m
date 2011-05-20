From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 20 May 2011 00:52:48 -0600
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTik7BnJKWCsm2L3-GJPTaaiXFNSgaA@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
	<BANLkTindee6UMez8HyBUwd2H6mN-DknzPw@mail.gmail.com>
	<BANLkTik7BnJKWCsm2L3-GJPTaaiXFNSgaA@mail.gmail.com>
Message-ID: <20110520065248.GB21285@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 02:25:47PM +0200, Linus Walleij wrote:
> On Thu, May 19, 2011 at 1:38 PM, Barry Song <21cnbao@gmail.com> wrote:
> 
> >> -arch_initcall(u300_gpio_init);
> >> -module_exit(u300_gpio_exit);
> >>
> > looks like the driver can't be a real module, is the module_exit
> > suitable? it looks strange module_exit plays together with
> > arch_initcall.
> 
> It's a rather common design pattern in the kernel for early
> platform drivers. Either the dependencies are resolved by the
> different initlevels or they are resolved in probe order with
> loadable modules. Module load will call all initlevels in order.
> 
> It is not elegant but it is common.

but it does need to be fixed.  Unfortunately it is not simple.  What
is needed is a generic deferral or ability for drivers to declare
dependences on other devices beyond their immediate parent.

I've thought about this a bit on and off over the last year, but I
haven't actually sat down to try and hack anything out yet.

g.
