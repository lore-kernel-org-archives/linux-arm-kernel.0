From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 15 Sep 2011 13:15:12 +0100
Subject: [PATCHv2 3/3] picoxcell: add the DTS for the PC7302 board
In-Reply-To: <1316086322.2602.1.camel@pasglop>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
	<1314196906-20709-4-git-send-email-jamie@jamieiles.com>
	<1316086322.2602.1.camel@pasglop>
Message-ID: <20110915121512.GG3089@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 08:32:02AM -0300, Benjamin Herrenschmidt wrote:
> On Wed, 2011-08-24 at 15:41 +0100, Jamie Iles wrote:
> 
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200 earlyprintk loglevel=9 root=ubi0:rootfs rw rootfstype=ubifs ubi.mtd=5,2048";
> > +		linux,stdout-path = &uart0;
> > +	};
> 
> Hrm... we don't normally put the bootargs in the device-tree.
> 
> Either you have a way to pass it from a previous firmware (which
> can then slap it into the device-tree at runtime), or you
> can have a way to compile it in the kernel image but the device-tree
> isn't the right place for it.

OK, that's fair enough.  A few other ARM platforms (tegra, prima2 and 
zynq) have bootargs in the chosen node and that's where I got it from, 
but our bootloader has fdt support so this can easily be removed.

Thanks,

Jamie
