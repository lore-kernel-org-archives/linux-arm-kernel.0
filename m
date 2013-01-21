From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 20:14:20 +0000
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <20130121184237.GC10106@arwen.pp.htv.fi>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-14-git-send-email-arnd@arndb.de>
 <20130121184237.GC10106@arwen.pp.htv.fi>
Message-ID: <201301212014.20678.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Felipe Balbi wrote:
> On Mon, Jan 21, 2013 at 05:16:06PM +0000, Arnd Bergmann wrote:
> > Manjunath Goudar is already working on a patch to convert
> > both the imx and the mvebu glue drivers (along with all
> > the other ARM specific ones) to the new probing method,
> > but that will be too late to fix v3.8. This patch instead
> > adds yet another hack like the existing ones to allow
> > the ehci driver to load both back-ends.
> 
> NAK, should be converted to the new usage of ehci library driver. Alan
> Stern already implemented for a few drivers, help is very welcome.

As I explained above, Manjunath already has a patch [1] for that, but I
think it's too late to include that in v3.8 given the regression
potential and size of the patch. Once he submits that patch for 3.9,
my change would get taken out anyway, but it lets us build important
configurations (including allyesconfig build tests) on 3.8.

	Arnd

[1] http://git.linaro.org/gitweb?p=people/manjunathgoudar/usb-refactoring.git;a=commitdiff;h=d9f28dba727212d022605c955796a3a83b3978ae
