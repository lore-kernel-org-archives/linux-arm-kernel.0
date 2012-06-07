From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jun 2012 04:20:31 -0600 (MDT)
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
In-Reply-To: <20120607075158.GZ12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
Message-ID: <alpine.DEB.2.00.1206070406050.6684@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120607 00:44]:
> > On Thu, 7 Jun 2012, Tony Lindgren wrote:
> > 
> > > Here too I think driver like features like this should live in the
> > > driver init for omap OHCI driver. In the likely case that FS OHCI is
> > > not in use on the board, the OHCI glue can just reset it.
> > 
> > What if the driver is not compiled into the kernel, but instead is built 
> > as a loadable module?
> 
> You can still have a core piece of the driver that's always built in, such
> as omap-ohci-common. But it should live under drivers, not in the bus level
> code. Or you can insmod/rmmod it to reset things properly.

Do you know of any device drivers that do this now, with a core built-in 
piece separate from a dynamically loadable part?

Seems like it would be tricky to avoid linking in the entire driver, due 
to the symbol dependencies.  Either that, or an extra, largely useless, 
layer of indirection would be needed in the shim layer.


- Paul
