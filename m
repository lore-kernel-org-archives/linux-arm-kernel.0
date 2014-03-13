From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Mar 2014 16:44:51 -0500
Subject: [PATCH][next] phy: core: make NULL a valid phy reference if
 !CONFIG_GENERIC_PHY
In-Reply-To: <20140313152024.GF4599@saruman.home>
References: <1394709073-1980-1-git-send-email-grygorii.strashko@ti.com>
 <20140313152024.GF4599@saruman.home>
Message-ID: <20140313214450.GG27355@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 13, 2014 at 10:20:24AM -0500, Felipe Balbi wrote:
> On Thu, Mar 13, 2014 at 01:11:13PM +0200, Grygorii Strashko wrote:
> > This fixes a regression on Keystone 2 platforms caused by patch
> > 57303488cd37da58263e842de134dc65f7c626d5
> > "usb: dwc3: adapt dwc3 core to use Generic PHY Framework" which adds
> > optional support of generic phy in DWC3 core.
> > 
> > On Keystone 2 platforms the USB is not working now because
> > CONFIG_GENERIC_PHY isn't set and, as result, Generic PHY APIs stubs
> > return -ENOSYS always. The log shows:
> >  dwc3 2690000.dwc3: failed to initialize core
> >  dwc3: probe of 2690000.dwc3 failed with error -38
> > 
> > Hence, fix it by making NULL a valid phy reference in Generic PHY
> > APIs stubs in the same way as it was done by the patch
> > 04c2facad8fee66c981a51852806d8923336f362 "drivers: phy: Make NULL
> > a valid phy reference".
> > 
> > CC: Kishon Vijay Abraham I <kishon@ti.com>
> > CC: Felipe Balbi <balbi@ti.com>
> > CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> nice :-)
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Greg, if your tree isn't closed yet, could you consider this patch still
for v3.15 merge window ? Grygorii found a regression on Keystone
platforms which this patch fixes. Let me know if you need the original
patch and myself or Kishon can send it to you.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/55851acc/attachment.sig>
