From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 15:24:50 +0300
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <CAAe_U6+dkiQw-i93pFapt6qKrArzaQoE8X3GjDzUDraziG8B2Q@mail.gmail.com>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <1340370942-23201-2-git-send-email-kishon@ti.com>
 <20120623044445.GA2993@kroah.com>
 <CAAe_U6+dkiQw-i93pFapt6qKrArzaQoE8X3GjDzUDraziG8B2Q@mail.gmail.com>
Message-ID: <20120625122449.GA30463@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 25, 2012 at 11:09:54AM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi Greg,
> 
> On Sat, Jun 23, 2012 at 10:14 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jun 22, 2012 at 06:45:41PM +0530, Kishon Vijay Abraham I wrote:
> >> Adds a new driver _ocp2scp_.
> >
> > That's not what you called this driver in the patch below :(
> >
> >> This driver takes the responsibility of creating
> >> all the devices that is connected to OCP2SCP. In the case of OMAP4, USB2PHY
> >> is connected to ocp2scp.
> >>
> >> This also includes device tree support for ocp2scp driver and
> >> the documentation with device tree binding information is updated.
> >
> > Can't this live where the scp drivers live? ?Actually, where is that at?
> > Do we have scp drivers?
> AFAIK, there isn't any driver for scp. But we have a driver for ocp
> and it is present at arch/arm/mach-omap2/omap_l3_noc.c

I don't think this deserves a directory of its own. Maybe
drivers/platform/arm/omap/ ?? the l3_noc is an OMAP-specific
interconnect and the SCP bus is also an OMAP-specific bus. I don't know
of any other arch/soc who uses the same interconnect IP as OMAP and the
same ocp2scp bridge. That bridge was created by TI for all I know.

Greg, would drivers/platform/arm/omap/ work for you ? We could also move
the interconnect drivers there.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/b26d08a2/attachment.sig>
