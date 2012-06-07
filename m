From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Jun 2012 10:55:42 +0300
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
In-Reply-To: <20120607075158.GZ12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
Message-ID: <20120607075541.GF16342@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 12:51:58AM -0700, Tony Lindgren wrote:
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

that's such a hack... both solutions are quite hacky. The only problem
here is because some bootloaders are leaving controller in an unknown
state and I guess to be completely safe, resets should be done before
any driver kicks in.

But, driver will probably reset again the IP block during probe...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/71c77cbd/attachment.sig>
