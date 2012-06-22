From: balbi@ti.com (Felipe Balbi)
Date: Fri, 22 Jun 2012 13:15:34 +0300
Subject: [PATCH 1/2] ARM: OMAP2+: Fix MUSB ifdefs for platform init code
In-Reply-To: <20120613101506.18645.98406.stgit@muffinssi.local>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101506.18645.98406.stgit@muffinssi.local>
Message-ID: <20120622101533.GC28472@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 03:15:06AM -0700, Tony Lindgren wrote:
> Commit 62285963 (usb: musb: drop a gigantic amount of ifdeferry)
> got rid of a bunch of ifdefs in the MUSB code. Looks like the
> platform init code is still using these dropped defines though,
> which in many cases results the board defaulting always to host
> mode.
> 
> Currently the situation is that USB_MUSB_HDRC is the main
> Kconfig option with additional USB_GADGET_MUSB_HDRC so only
> these two should be used to select between host and OTG mode.
> 
> Fix the situation for omaps. The following users should fix the
> platform init code in a similar way:
> 
> Dropped Kconfig option          Current users
> 
> USB_MUSB_OTG                    blackfin, davinci, not in Kconfigs
> USB_MUSB_PERIPHERAL             davinci, not in Kconfigs
> USB_MUSB_HOST                   davinci, not in Kconfigs
> USB_MUSB_HDRC_HCD               blackfin, not in Kconfigs
> USB_MUSB_OTG                    blackfin, not in Kconfigs
> 
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: linux-usb at vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks ok, though I would stick to things boards are wired to do. e.g.:

all development boards are wired for OTG (with a few exceptions),
n800 is peripheral only
n810 is OTG

and so on. That way you remove all the clutter.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120622/1655eeeb/attachment.sig>
