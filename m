From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Apr 2012 23:31:51 +0300
Subject: [PATCH v2 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <4F9703C2.50002@wwwdotorg.org>
References: <1335269116-9578-1-git-send-email-hdoyu@nvidia.com>
 <20120424121619.GF8444@arwen.pp.htv.fi>
 <4F9703C2.50002@wwwdotorg.org>
Message-ID: <20120424203150.GA9176@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 01:49:22PM -0600, Stephen Warren wrote:
> On 04/24/2012 06:16 AM, Felipe Balbi wrote:
> > On Tue, Apr 24, 2012 at 03:05:14PM +0300, Hiroshi DOYU wrote:
> >> The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> >> High-performance Bus (AHB) architecture.
> ...
> >> +static int __init tegra_ahb_init(void)
> >> +{
> >> +	return platform_driver_register(&tegra_ahb_driver);
> >> +}
> >> +postcore_initcall(tegra_ahb_init);
> >> +
> >> +static void __exit tegra_ahb_exit(void)
> >> +{
> >> +	platform_driver_unregister(&tegra_ahb_driver);
> >> +}
> >> +module_exit(tegra_ahb_exit);
> > 
> > please use module_platform_driver();
> 
> That won't work for a postcore_initcall.

aaah, indeed. Missed that part ;-) My bad.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/98fe68c4/attachment.sig>
