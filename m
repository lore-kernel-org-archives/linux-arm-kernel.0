From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 15:32:13 -0600
Subject: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
In-Reply-To: <5280EB5C.1040001@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <20131017163828.GH11611@gimli> <5280EB5C.1040001@ti.com>
Message-ID: <20131125213213.GV18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 11, 2013 at 08:06:12PM +0530, Kishon Vijay Abraham I wrote:
> >> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
> >> index 7db34f0..49ffa6d 100644
> >> --- a/drivers/usb/dwc3/platform_data.h
> >> +++ b/drivers/usb/dwc3/platform_data.h
> >> @@ -24,4 +24,6 @@ struct dwc3_platform_data {
> >>  	enum usb_device_speed maximum_speed;
> >>  	enum usb_dr_mode dr_mode;
> >>  	bool tx_fifo_resize;
> >> +	bool usb2_phy;
> >> +	bool usb3_phy;
> > 
> > This would look better as a quirks flag, then we could:
> > 
> > unsigned long quirks;
> > #define DWC3_QUIRK_NO_USB3_PHY	BIT(0)
> > #define DWC3_QUIRK_NO_USB2_PHY	BIT(1)
> 
> Should this quirk be used for dt also? Currently we find if it has usb3 phy or
> usb2 phy from the dt data only. But if we add a quirk, we'll have to add a
> property to populate the quirk no?

either we use the quirk, or use the fact that no <&usb2_phy> phandle is
defined, would work both ways, no ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/4316a399/attachment.sig>
