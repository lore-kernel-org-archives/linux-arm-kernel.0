From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 13:48:59 +0200
Subject: [RFC PATCH 0/6] USB: Add multiple PHYs of same type
In-Reply-To: <1358348462-27693-1-git-send-email-kishon@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
Message-ID: <20130118114859.GC4379@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 08:30:56PM +0530, Kishon Vijay Abraham I wrote:
> New platforms are being added which has multiple PHY's (of same type) and
> which has multiple USB controllers. The binding information has to be
> present in the PHY library (otg.c) in order for it to return the
> appropriate PHY whenever the USB controller request for the PHY. So
> added a new API to pass the binding information. This API should be
> called by platform specific initialization code.
> 
> So the binding should be done something like
> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying the USB
> controller device name, index, and the PHY device name.
> I have done this binding for OMAP platforms, but it should be done for
> all the platforms.
> 
> After this design, the phy can be got by passing the USB controller device
> pointer and the index.
> 
> Developed this patch series on
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> after applying "usb: musb: add driver for control module" patch series.
> 
> Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.

please resend without RFC so I can apply.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/b16f5fe2/attachment.sig>
