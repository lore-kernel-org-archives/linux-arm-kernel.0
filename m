From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 13:00:14 +0300
Subject: [PATCH v7 2/9] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <51C02EC7.7060908@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-3-git-send-email-kishon@ti.com>
 <20130618094058.GQ5461@arwen.pp.htv.fi> <51C02D0F.6010302@ti.com>
 <20130618095040.GZ5461@arwen.pp.htv.fi> <51C02EC7.7060908@ti.com>
Message-ID: <20130618100014.GD5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 03:26:23PM +0530, Kishon Vijay Abraham I wrote:
> >>>On Thu, Jun 13, 2013 at 02:13:52PM +0530, Kishon Vijay Abraham I wrote:
> >>>>@@ -159,6 +191,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
> >>>>  	otg->start_srp		= omap_usb_start_srp;
> >>>>  	otg->phy		= &phy->phy;
> >>>>
> >>>>+	pm_runtime_enable(phy->dev);
> >>>
> >>>enabling pm_runtime here has the potential to cause a real big problem.
> >>>How have you tested this patch ?
> >>
> >>performed boot and enumeration testing. What issue do you expect here?
> >
> >hint: look at drvdata usage around the driver. Where is it initialized ?
> >Where is it used ?
> 
> hmm.. since runtime_get calls weren't made very early, I think I dint
> see any issues. Thanks for pointing this.

right, no problem. BTW, you don't get to_platform_device() ->
platform_get_drvdata(). A simple dev_get_drvdata() is sufficient :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/4631ffe0/attachment.sig>
