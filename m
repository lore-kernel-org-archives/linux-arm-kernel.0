From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  8 Jul 2015 16:41:36 +0200
Subject: [PATCH v6 0/4] musb: sunxi: Add support for the Allwinner sunxi musb
Message-ID: <1436366500-12555-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

As requested here is a new version of my "musb: sunxi: Add support for the
Allwinner sunxi musb controller" patch, fixing the "Should it be static?"
compiler warning.

While working on this I noticed that sun4i_usb_phy_set_squelch_detect()
from phy-sun4i-usb.c is missing an EXPORT_SYMBOL, something which I did
not notice before I was always building both phy-sun4i-usb and musb
into the kernel.

I've added a patch fixing this, and I'm posting a new version of the
entire set including this patch.

I believe that like the original patch adding the
sun4i_usb_phy_set_squelch_detect function, this patch should go upstream
through your (Felipe's) tree as the musb-sunxi patches depend on this.

The other oustanding phy-sun4i-usb patches can still go upstream through
Kishon's tree, they do not conflict with the small patch fixing the
missing EXPORT_SYMBOL.

Thanks & Regards,

Hans
