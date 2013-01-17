From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 11:32:07 +0200
Subject: [PATCH v5 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <20130117092829.GA8251@nchen-desktop>
References: <1358216975-1404-1-git-send-email-peter.chen@freescale.com>
 <1358216975-1404-2-git-send-email-peter.chen@freescale.com>
 <20130115140344.GB6574@S2101-09.ap.freescale.net>
 <20130116014824.GD16514@nchen-desktop>
 <20130117091422.GF10814@arwen.pp.htv.fi>
 <20130117092829.GA8251@nchen-desktop>
Message-ID: <20130117093207.GG10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 05:28:30PM +0800, Peter Chen wrote:

<trimming>

> > > > From what I understand balbi's comment, he dislikes this full list of
> > > > device id.  Instead, he prefers to something like below.
> > > > 
> > > > static const struct platform_device_id fsl_udc_devtype[] = {
> > > > 	{
> > > > 		.name = "imx-udc-mx27",
> > > > 	}, {
> > > > 		.name = "imx-udc-mx51",
> > > > 	}
> > > > };
> > > > 
> > > > It basically tells that we are handling two type of devices here, one
> > > > is imx-udc-mx27 type and the other is imx-udc-mx51 type, with mx25/31/35
> > > > completely compatible with mx27 type.  We choose mx27 instead of mx25
> > > > to define the type because mx27 Si came out earlier than mx25.  That
> > > > said, we generally choose the earlies SoC name to define a particular
> > > > version of IP block, since hardware version is mostly unavailable or
> > > > unreliable.
> > > > 
> > > > But that also means in platform code which create the platform_device,
> > > > you will need to use name "imx-udc-mx27" for even mx25/31/35.
> > > > 
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx27");
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx27");
> > > > 
> > > > Considering this is a piece of code we will not use for any new
> > > > hardware, I'm fine with either way.
> > > > 
> > > > So, balbi, it's all your call to accept the series as it is or ask for
> > > > another iteration.
> > 
> > right :-)
> > 
> > > Thanks Shawn. Let's see Felipe's comment, nevertheless, I will send v6 patch
> > > due to a compile error at mx25
> > 
> > Shawn is right.
> 
> In fact, this driver is just the temp solution, we will use chipidea
> in future, so just take all i.mx usb as two kinds of ip are ok.
> 
> Do you want me to change like Shawn said, or current version is ok?

yes, please resend with changes.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/fb5dea96/attachment.sig>
