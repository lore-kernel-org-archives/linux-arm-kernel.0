From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 13:48:04 +0200
Subject: [PATCH v7 17/22] mfd: omap-usb-host: clean up omap_usbhs_init()
In-Reply-To: <1358422231-24736-18-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-18-git-send-email-rogerq@ti.com>
Message-ID: <20130117114804.GG18978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 01:30:26PM +0200, Roger Quadros wrote:
> +	if (is_omap_usbhs_rev1(omap))
> +		reg = omap_usbhs_rev1_hostconfig(omap, reg);
> +	else if (is_omap_usbhs_rev2(omap))
> +		reg = omap_usbhs_rev2_hostconfig(omap, reg);

Any way you could maybe:

rev = omap_usbhs_revision(omap)
switch(rev) {
case REV1:
	foo();
	break;
case REV2:
	bar();
	break;
default:	/* highest revision */
	baz();
}

could be done in a later patch however.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/65ddb966/attachment.sig>
