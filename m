From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 13:48:43 +0200
Subject: [RFC PATCH 1/6] usb: otg: Add an API to bind the USB controller
 and PHY
In-Reply-To: <50F7DD2C.90500@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-2-git-send-email-kishon@ti.com>
 <50F7C643.600@ti.com> <50F7DD2C.90500@ti.com>
Message-ID: <20130118114843.GB4379@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 04:44:52PM +0530, kishon wrote:
> >>@@ -171,6 +188,11 @@ static inline void devm_usb_put_phy(struct device *dev, struct usb_phy *x)
> >>  {
> >>  }
> >>
> >>+static inline struct usb_phy_bind *usb_bind_phy(const char *dev_name, u8 index,
> >>+				const char *phy_dev_name)
> >>+{
> >>+	return NULL;
> >>+}
> >>  #endif
> >>
> >>  static inline int
> >>
> >
> >Controllers like ehci-omap which don't need OTG functionality would
> >benefit from this API. Can we make these PHY APIs not dependent on OTG /
> >OTG_UTILS?
> 
> Actually much of whatever is in otg.c can be used by controllers
> which don't have OTG functionality (except otg_state_string). I
> vaguely remember, there was a patch that renamed otg.c to phy.c etc..
> I'm not sure what happened to that.

right, that has to be done eventually ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/b6f7337c/attachment.sig>
