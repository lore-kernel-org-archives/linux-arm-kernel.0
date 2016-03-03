From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 3 Mar 2016 13:33:43 +0100
Subject: [RFC 11/15] power: reset: keystone: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <5230562.E0gg2SNP0m@wuerfel>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
 <5230562.E0gg2SNP0m@wuerfel>
Message-ID: <20160303123343.GB5687@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 03, 2016 at 12:00:14PM +0100, Arnd Bergmann wrote:
> On Thursday 03 March 2016 17:03:37 Krzysztof Kozlowski wrote:
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 0a6408a39c66..0f34846ae80d 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -141,6 +141,7 @@ config POWER_RESET_XGENE
> >  config POWER_RESET_KEYSTONE
> >         bool "Keystone reset driver"
> >         depends on ARCH_KEYSTONE
> > +       depends on HAS_IOMEM    # For MFD_SYSCON
> >         select MFD_SYSCON
> >         help
> >           Reboot support for the KEYSTONE SoCs.
> > 
> 
> This is platform specific, but we should probably add || COMPILE_TEST
> along with the HAS_IOMEM dependency.

Sounds sensible. Will you guys send an updated patch?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/7d170111/attachment.sig>
