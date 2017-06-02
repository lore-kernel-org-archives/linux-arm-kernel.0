From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Jun 2017 14:15:32 +0200
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun8i-a83t
In-Reply-To: <CAK8P3a2-hoVKFOr455ZseM4UrmHGFXTE7VbXpSd2Jdp7rnrKyA@mail.gmail.com>
References: <20170522202951.2896280-1-arnd@arndb.de>
 <20170523005553.GH20170@codeaurora.org>
 <20170523071940.xbnahikb4d5dge7v@wens.csie.org>
 <CAK8P3a37CT0tzdy4V8Hj=-Mu=JrdR08zv2fqVH5Y+hzT7OK4Vg@mail.gmail.com>
 <20170601071750.GP20170@codeaurora.org>
 <CAK8P3a2-hoVKFOr455ZseM4UrmHGFXTE7VbXpSd2Jdp7rnrKyA@mail.gmail.com>
Message-ID: <20170602121532.glfjkxp333ynvcwm@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 11:07:46AM +0200, Arnd Bergmann wrote:
> On Thu, Jun 1, 2017 at 9:17 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 05/23, Arnd Bergmann wrote:
> >> On Tue, May 23, 2017 at 9:19 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> >> An alternative would be to remove all the dependencies as 'lib-y'
> >> in the Makefile and remove the individual Kconfig symbols. That
> >> way, we would always build all of them when CONFIG_SUNXI_CCU
> >> is enabled, but the linker would drop the ones that do not get
> >> referenced.
> >
> > In this case you're right, and we should change them to lib-y in
> > the Makefile and then let the linker figure this all out. No more
> > dependency patches. I think we only need to do this sort of
> > Kconfig stuff when we want to make a library .ko file that each
> > SoC specific driver depends on for common code.
> >
> > It would be cool if the build system could figure that all out
> > for us, and let us have something like modlib-y that makes it a
> > library (archive) if all objects depending on it are builtin and
> > we have CONFIG_MODULES=n, or makes it into an object file if
> > something is builtin that depends on it, or makes it into a
> > module if everything that depends on it is a module.
> 
> In this case, there are no loadable modules, the sunxi clk drivers
> can only be built-in, which should simplify the problem a lot.

Using the linker to drop the useless stuff seems like a good idea. Do
you want to send a patch for it?

Maxim

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/4dd131fe/attachment.sig>
