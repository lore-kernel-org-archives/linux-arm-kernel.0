From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Sep 2012 15:57:59 +0300
Subject: [PATCH 1/6] usb: dwc3-omap: use of_platform API to create dwc3
 core pdev
In-Reply-To: <1348836795-4783-2-git-send-email-kishon@ti.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-2-git-send-email-kishon@ti.com>
Message-ID: <20120928125758.GK31006@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 28, 2012 at 06:23:10PM +0530, Kishon Vijay Abraham I wrote:
> Used of_platform_populate() to populate dwc3 core platform_device
> from device tree data. Since now the allocation of unique device id is
> handled be of_*, removed the call to dwc3_get_device_id.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

I think it's best if you split the use of device_for_each_child() from
this patch. So first do the device_for_each_child() part, then later use
of_platform_populate().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120928/1d7513b6/attachment.sig>
