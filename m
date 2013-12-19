From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Dec 2013 08:33:56 -0600
Subject: [PATCH v7 8/9] phy: add Broadcom Kona USB2 PHY driver
In-Reply-To: <52B288EF.1040006@ti.com>
References: <1387309356-17195-1-git-send-email-mporter@linaro.org>
 <1387309356-17195-9-git-send-email-mporter@linaro.org>
 <20131218162554.GF4970@saruman.home> <52B288EF.1040006@ti.com>
Message-ID: <20131219143356.GE3985@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 19, 2013 at 11:19:35AM +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 18 December 2013 09:55 PM, Felipe Balbi wrote:
> > On Tue, Dec 17, 2013 at 02:42:35PM -0500, Matt Porter wrote:
> >> Add a driver for the internal Broadcom Kona USB 2.0 PHY found
> >> on the BCM281xx family of SoCs.
> >>
> >> Signed-off-by: Matt Porter <mporter@linaro.org>
> > 
> > Kishon, are you ok with this driver ?
> 
> yeah. Since this patch touches phy/Kconfig (and Makefile) and there is
> one more PHY driver to be merged that also modifies Kconfig there
> might be conflicts. So thought I should be taking this patch?

this PHY driver depends on the new ->get_bus_width()/->set_bus_width()
methods which Matt just added. There's no easy way to make sure we avoid
conflicts and/or build errors.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/44ca1c6e/attachment.sig>
