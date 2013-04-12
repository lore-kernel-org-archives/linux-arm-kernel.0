From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 15:01:48 +0200
Subject: [PATCH] ARM: pci: pass a parent to pci_common_init()
In-Reply-To: <20130412120538.GA32488@arm.com>
References: <1365719096-11639-1-git-send-email-linus.walleij@linaro.org>
 <201304121326.56030.arnd@arndb.de> <20130412120538.GA32488@arm.com>
Message-ID: <201304121501.48866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013, Andrew Murray wrote:
> I would also be happy with this. Though alternatively could you
> not just add a struct device to hw_pci? Then change pcibios_init_hw
> to use hw->device instead of NULL?
> 

I think struct hw_pci is meant to be statically defined, so that would
not work if you need the same hw_pci for two host bridge devices.

	Arnd
