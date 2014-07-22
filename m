From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 Jul 2014 09:47:43 -0500
Subject: [PATCH 8/9] usb: phy: am335x: call
 usb_gen_phy_init()/usb_gen_phy_shutdown() in am335x_init()/am335x_shutdown()
In-Reply-To: <20140722100613.779a3e11@ipc1.ka-ro>
References: <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
 <20140718135713.GH24914@saruman.home>
 <20140721100307.21172b65@ipc1.ka-ro>
 <20140721151043.GF6852@saruman.home>
 <20140722100613.779a3e11@ipc1.ka-ro>
Message-ID: <20140722144743.GB20588@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 10:06:13AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Felipe Balbi wrote:
> > Hi,,
> > 
> > On Mon, Jul 21, 2014 at 10:03:07AM +0200, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > > On Fri, Jul 18, 2014 at 11:31:29AM +0200, Lothar Wa?mann wrote:
> > > > > This patch makes it possible to use the musb driver with HW that
> > > > > requires external regulators or clocks.
> > > > 
> > > > can you provide an example of such HW ? Are you not using the internal
> > > > PHYs ?
> > > > 
> > > The Ka-Ro electronics TX48 module uses the mmc0_clk pin as VBUSEN
> > > rathern than usb0_drvvbus. This patch makes it possible to use an
> > > external regulator to handle the VBUS switch through the 'vcc-supply'
> > > property of the underlying generic_phy device.
> > 
> > OK, I get it now. But why would not use usb0_drvvbus ? You could still
> > route usb0_drvvbus to the regulator enable pin and the regulator would
> > be enabled for you once correct values are written to the IP's mailbox.
> > 
> > I suppose this has something to do with layout constraints ?
> > 
> Yes. The usb0_drvvbus is used for a different purpose.

alright, thanks for the info. I'll revisit this in a few days, quite
busy right now and my tree is closed for v3.17 anyway.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140722/191cc982/attachment-0001.sig>
