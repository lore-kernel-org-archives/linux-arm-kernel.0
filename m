From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 May 2012 13:35:17 +0300
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <20120522103139.GD32035@b20223-02.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <201205220630.57007.marex@denx.de>
 <20120522045120.GL6206@b20223-02.ap.freescale.net>
 <87fwasbkt7.fsf@ashishki-desk.ger.corp.intel.com>
 <20120522100624.GP30559@arwen.pp.htv.fi>
 <20120522103139.GD32035@b20223-02.ap.freescale.net>
Message-ID: <20120522103516.GR30559@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 06:31:40PM +0800, Richard Zhao wrote:
> On Tue, May 22, 2012 at 01:06:26PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, May 22, 2012 at 12:56:52PM +0300, Alexander Shishkin wrote:
> > > > Do you think it's a good idea to let user select binding driver directly
> > > > and the binding driver config depends on chipidea config?
> > > 
> > > I don't have a strong opinion on this, although I prefer it the way it
> > > is now, because, imo:
> > > 
> > >   * in case of =m (and that's the only sane way of compiling it anyway),
> > >     these all are compiled as modules, which you simply don't install if
> > >     you don't want them;
> > >   * all of them get compile-tested every time you change something in
> > >     the driver, which is a good thing;
> > 
> > only true for $(ARCH) builds. I would like to see these drivers being
> > compile tested on linux-next on all arches. Thus the patches I just
> > sent.
> The idea is great. But
> - how can I make sure it pass for all arch? There' 27 folder in arch/.
> - it's hard to predict one driver depends on what.
> - for embedded kernel, people like built-in drivers, and people will
>   have things they don't need at all.

that's true to some extent, but until we know for sure that all of that
is compiling fine and all dependencies are properly handled, I wouldn't
like to see Kconfig or Makefile being abused. That has happened before
and will happen again if we allow it.

My suggestion to Alex is to remove all dependencies for at least a
couple of merge windows and only add dependencies for stuff which
actually matters; like only building the PCI glue layer when CONFIG_PCI
is defined instead of when ARCH_X86 is defined and so on.

When it gets to a product, that can be easily optimized and when we have
decided what's the best way to place the choices, we will do so. Until
then, we like to use linux-next for compile testing everything.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/433f4274/attachment-0001.sig>
