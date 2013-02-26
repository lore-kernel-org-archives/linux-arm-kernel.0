From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Feb 2013 20:21:41 +0200
Subject: [PATCH v8 8/8] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130217030951.GA1588@nchen-desktop>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-9-git-send-email-peter.chen@freescale.com>
 <20130213084128.GB2426@arwen.pp.htv.fi>
 <20130217030951.GA1588@nchen-desktop>
Message-ID: <20130226182141.GB2626@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 17, 2013 at 11:09:53AM +0800, Peter Chen wrote:
> @@ -1373,6 +1375,8 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
>  			hw_device_state(ci, ci->ep0out->qh.dma);
>  			dev_dbg(ci->dev, "Connected to host\n");
>  		} else {
> +			if (ci->driver)
> +				ci->driver->disconnect(&ci->gadget);

This looks wrong. Why do you need to call ->disconnect() here ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130226/e9160490/attachment.sig>
