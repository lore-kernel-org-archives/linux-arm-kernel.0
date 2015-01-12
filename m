From: balbi@ti.com (Felipe Balbi)
Date: Mon, 12 Jan 2015 15:51:59 -0600
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <CALT56yOaX0EQbbFSXiFK=uqSpCwv4pQsU4QFMSmSoTstq2d7zw@mail.gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
 <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
 <20150108165834.GH31926@saruman>
 <CALT56yOaX0EQbbFSXiFK=uqSpCwv4pQsU4QFMSmSoTstq2d7zw@mail.gmail.com>
Message-ID: <20150112215159.GM2858@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 10:44:59PM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> 2015-01-08 19:58 GMT+03:00 Felipe Balbi <balbi@ti.com>:
> > On Sun, Nov 30, 2014 at 01:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
> >> Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
> >> driver determines connector/VBUS status by reading CPLD register. Also
> >> it uses a work to call into udc stack, instead of pinging vbus session
> >> right from irq handler.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  drivers/usb/phy/Kconfig       |  10 ++
> >>  drivers/usb/phy/Makefile      |   1 +
> >
> > new phy drivers under drivers/phy only, sorry.
> 
> Hmm. How do drivers/phy drivers coordinate with usb gadget subsystem?
> I see none of them calling usb_gadget_vbus_connect/disconnect().

I'll leave that to Kishon, since he wrote drivers/phy. Kishon, any
hints?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/3d24ea70/attachment-0001.sig>
