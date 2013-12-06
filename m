From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 06 Dec 2013 13:28:51 +0400
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131206001728.GJ4360@n2100.arm.linux.org.uk>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <20131206000253.GC21358@kroah.com>
 <20131206001728.GJ4360@n2100.arm.linux.org.uk>
Message-ID: <1386322131.7152.36.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-06 at 00:17 +0000, Russell King - ARM Linux wrote:

> I may be able to - one of the downsides though is that many of these
> systems had hard-coded scripts which started a getty on the original
> port - and that kind of makes it difficult to sort out.  This kind of
> change becomes very much one of Linus' "flag days".

> So I'd suggest that we have a period where the old driver is still
> available, so at least people can choose to use the old major/minor
> numbers for a while.

The patch doesn't change how the driver looks from the outside. The old
driver was using 8250 name (ttyS), major (4) and first minor (64). So we
only resolve an internal conflict.

Kernel configuration is the place where issues may appear, since the
patch removes CONFIG_SERIAL_PXA_CONSOLE option. I've updated all
in-kernel users. However, out-of-kernel configs will no longer provide
serial console, unless manually reconfigured. Is this the case we should
worry about?
