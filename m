From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2016 16:24:30 +0100
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
Message-ID: <20160801152430.GM5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 04:42:29PM +0530, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.

You're changing more than just platforms that are part of
ARCH_MULTIPLATFORM.  Eg, ARCH_DOVE and ARCH_IXP4XX.  So, these will
probably end up losing PCI support as a result of this change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
