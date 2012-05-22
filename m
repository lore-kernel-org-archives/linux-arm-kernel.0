From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 18:31:40 +0800
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <20120522100624.GP30559@arwen.pp.htv.fi>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <201205220630.57007.marex@denx.de>
 <20120522045120.GL6206@b20223-02.ap.freescale.net>
 <87fwasbkt7.fsf@ashishki-desk.ger.corp.intel.com>
 <20120522100624.GP30559@arwen.pp.htv.fi>
Message-ID: <20120522103139.GD32035@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:06:26PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, May 22, 2012 at 12:56:52PM +0300, Alexander Shishkin wrote:
> > > Do you think it's a good idea to let user select binding driver directly
> > > and the binding driver config depends on chipidea config?
> > 
> > I don't have a strong opinion on this, although I prefer it the way it
> > is now, because, imo:
> > 
> >   * in case of =m (and that's the only sane way of compiling it anyway),
> >     these all are compiled as modules, which you simply don't install if
> >     you don't want them;
> >   * all of them get compile-tested every time you change something in
> >     the driver, which is a good thing;
> 
> only true for $(ARCH) builds. I would like to see these drivers being
> compile tested on linux-next on all arches. Thus the patches I just
> sent.
The idea is great. But
- how can I make sure it pass for all arch? There' 27 folder in arch/.
- it's hard to predict one driver depends on what.
- for embedded kernel, people like built-in drivers, and people will
  have things they don't need at all.

Thanks
Richard
> 
> -- 
> balbi
