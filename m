From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Mar 2014 10:20:24 -0500
Subject: [PATCH][next] phy: core: make NULL a valid phy reference if
 !CONFIG_GENERIC_PHY
In-Reply-To: <1394709073-1980-1-git-send-email-grygorii.strashko@ti.com>
References: <1394709073-1980-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140313152024.GF4599@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 01:11:13PM +0200, Grygorii Strashko wrote:
> This fixes a regression on Keystone 2 platforms caused by patch
> 57303488cd37da58263e842de134dc65f7c626d5
> "usb: dwc3: adapt dwc3 core to use Generic PHY Framework" which adds
> optional support of generic phy in DWC3 core.
> 
> On Keystone 2 platforms the USB is not working now because
> CONFIG_GENERIC_PHY isn't set and, as result, Generic PHY APIs stubs
> return -ENOSYS always. The log shows:
>  dwc3 2690000.dwc3: failed to initialize core
>  dwc3: probe of 2690000.dwc3 failed with error -38
> 
> Hence, fix it by making NULL a valid phy reference in Generic PHY
> APIs stubs in the same way as it was done by the patch
> 04c2facad8fee66c981a51852806d8923336f362 "drivers: phy: Make NULL
> a valid phy reference".
> 
> CC: Kishon Vijay Abraham I <kishon@ti.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

nice :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/f77ff56e/attachment.sig>
