From: ynvich@gmail.com (Sergei Ianovich)
Date: Thu, 19 Dec 2013 00:56:33 +0400
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <201312182150.39037.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312161856.11384.arnd@arndb.de>
 <1387226300.13062.161.camel@host5.omatika.ru>
 <201312182150.39037.arnd@arndb.de>
Message-ID: <1387400193.31516.10.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-18 at 21:50 +0100, Arnd Bergmann wrote:
> > This is a platform-specific bus (PXA27x). Should it go into pxa27x.dtsi
> > rather than machine dts?
> 
> Yes, that was the idea.

Great.

> > There seems to be none at the moment. However, some machines need to
> > setup these partitions as a part of their initialization. So complete
> > migration to DT will require this driver.
> > 
> > In LP-8x4x case everything is setup by the bootloader. So "simple-bus"
> > works for me.
> 
> Hmm, this is a bit tricky then. I think it would be best to not
> use "simple-bus" then, to allow migrating the other platforms later,
> but that will be a little more work. Maybe you can register a trivial
> driver in the platform code that only calls of_platform_populate on
> the device for now?

Could we postpone this until someone needs this functionality?
