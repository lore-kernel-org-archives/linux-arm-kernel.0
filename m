From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 25 Apr 2014 22:25:36 +0200
Subject: [PATCH v2 03/18] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <5392399.GiPjM0CIZ0@wuerfel>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-4-git-send-email-gregory.clement@free-electrons.com>
 <5392399.GiPjM0CIZ0@wuerfel>
Message-ID: <20140425222536.430d5c4d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 25 Apr 2014 22:01:51 +0200, Arnd Bergmann wrote:

> I think you're doing it the wrong way around: You have a specialized
> version of the generic xhci-plat driver. The normal way to handle this
> is to have a loadable module that contains all the Armada specific
> code and that registers a platform_driver. In the probe() function of
> that driver, you can do the platform specific setup and then call
> the generic xhci_plat_probe() function, which of course has to
> be provided using EXPORT_SYMBOL_GPL.

You should have a look at the v1 Gregory sent: it was implementing
exactly what you suggest here, but Felipe explicitly requested the
patches to be changed like is now proposed in v2.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
