From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 26 Oct 2016 09:22:36 +0200
Subject: [PATCH 3/3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <5e0adad1-8ef2-029f-cfcd-4a07c962fda2@opensource.altera.com>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
 <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
 <20161020071913.rlka3or4c7fzjpyv@pengutronix.de>
 <c62baad6-2528-a9df-6b09-3dba66785102@opensource.altera.com>
 <5e0adad1-8ef2-029f-cfcd-4a07c962fda2@opensource.altera.com>
Message-ID: <20161026072235.ardwmhqbqgq376vu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Oct 25, 2016 at 10:38:10AM -0500, Graham Moore wrote:
> On 10/20/2016 09:12 AM, Dinh Nguyen wrote:
> > 
> > 
> > On 10/20/2016 02:19 AM, Steffen Trumtrar wrote:
> > 
> > > > +		cdns,tslch-ns = <4>;
> > > > +
> > > > +		partition at qspi-boot {
> > > > +			/* 8MB for raw data. */
> > > > +			label = "Flash 0 Raw Data";
> > > > +			reg = <0x0 0x800000>;
> > > > +		};
> > > > +
> > > > +		partition at qspi-rootfs {
> > > > +			/* 120MB for jffs2 data. */
> > > > +			label = "Flash 0 jffs2 Filesystem";
> > > > +			reg = <0x800000 0x7800000>;
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > 
> > > What is the current preferred way of handling the partitions?
> > > This doesn't fit my Sockit configuration for example. So I would always
> > > have to patch the devicetree.
> > 
> > I'm not 100% sure on this. Graham, do you have any insight?
> > > 
> 
> Well, strictly speaking, these partitions are only for the socdk, the Altera
> dev kit.  Our sample designs and file systems expect this layout.

The thing is, that I don't think these partitions belong in a mainline
dts at all. But I'm not sure what the current policy is.

> 
> Therefore, these partitions are not required for any other dev kits, and can
> probably be left out.
> 
> Or, Steffen, if you have a standard layout you'd like to see, then put that
> in there.
> 

Well in my case, it actually doesn't really matter. All the boards
I use do not have u-boot as bootloader but barebox. And barebox uses
devicetree fixups for adding the partition layout that fits the
particular use case. All other partitions are thrown out.
I don't know if u-boot does something like this.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
