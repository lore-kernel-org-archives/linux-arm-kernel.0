From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue, 3 Dec 2013 12:39:50 +0200
Subject: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
In-Reply-To: <20131017145425.GE11611@gimli>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <525E8E93.9010503@ti.com> <525E9046.3090209@ti.com>
 <525E943E.3080706@ti.com> <20131017145425.GE11611@gimli>
Message-ID: <20131203103950.GB26423@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 17, 2013 at 09:54:26AM -0500, Felipe Balbi wrote:
> On Wed, Oct 16, 2013 at 04:27:26PM +0300, Roger Quadros wrote:
> > On 10/16/2013 04:10 PM, Kishon Vijay Abraham I wrote:
> > Do you know if there are users of dwc3 other than exynos5250 and omap5?
> > If not, we should get rid of the old USB PHY altogether.
> 
> Intel's Baytrail, at least. But they don't use DT.

I don't see any use for the generic-phy when the device is enumerated
from PCI. If dwc3 can live without phys, there should not be any
problem dropping the old USB PHY support.

Br,

-- 
heikki
