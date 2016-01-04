From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Jan 2016 09:24:32 +0100
Subject: [PATCH 3/3] drm: arm-hdlcd: fix build warnings for !CONFIG_PM
In-Reply-To: <2621741.YulfsnvZOh@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
 <2621741.YulfsnvZOh@wuerfel>
Message-ID: <20160104082432.GC23797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 03:39:17PM +0100, Arnd Bergmann wrote:
> The hdlcd_pm_suspend and hdlcd_pm_resume are intentionally unused
> when CONFIG_PM is not set in this driver, and we get a compiler warning
> for this:
> 
> drivers/gpu/drm/arm/hdlcd_drv.c:521:12: warning: 'hdlcd_pm_suspend' defined but not used [-Wunused-function]
> drivers/gpu/drm/arm/hdlcd_drv.c:536:12: warning: 'hdlcd_pm_resume' defined but not used [-Wunused-function]
> 
> This adds a __maybe_unused annotation for the two functions, to let
> the compiler know this is the intended behavior. This is better than
> an #ifdef as it improves the compile time coverage of the code and it
> looks nicer.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/9e2bae63/attachment.sig>
