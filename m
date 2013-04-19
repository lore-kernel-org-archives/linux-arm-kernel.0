From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 14:06:59 +0100
Subject: [PATCH] ARM: pci: pass a parent to pci_common_init()
In-Reply-To: <201304121501.48866.arnd@arndb.de>
References: <1365719096-11639-1-git-send-email-linus.walleij@linaro.org>
 <201304121326.56030.arnd@arndb.de> <20130412120538.GA32488@arm.com>
 <201304121501.48866.arnd@arndb.de>
Message-ID: <20130419130659.GM14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:01:48PM +0200, Arnd Bergmann wrote:
> On Friday 12 April 2013, Andrew Murray wrote:
> > I would also be happy with this. Though alternatively could you
> > not just add a struct device to hw_pci? Then change pcibios_init_hw
> > to use hw->device instead of NULL?
> > 
> 
> I think struct hw_pci is meant to be statically defined, so that would
> not work if you need the same hw_pci for two host bridge devices.

The hw_pci structure is only referenced by the setup functions, and
never referred to again.  Anything of any relevance that is needed
later is copied out of that structure into others (like pci_sys_data).
