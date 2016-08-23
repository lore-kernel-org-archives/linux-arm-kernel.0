From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2016 11:02:01 +0100
Subject: [PATCH v05 54/72] include/uapi/xen/privcmd.h: fix compilation in
 userspace
In-Reply-To: <1471890809-4383-55-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
 <1471890809-4383-55-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <20160823100201.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 08:33:11PM +0200, Mikko Rapeli wrote:
> xen/interface/xen.h is not exported from kernel headers so remove the
> dependency and provide needed defines for domid_t and xen_pfn_t if they
> are not already defined by some other e.g. Xen specific headers.

I'm confused.  How did we end up with a 64-bit PFN number on ARM?  It's
insane - especially as the kernel uses "unsigned long" almost everywhere
for PFNs - we can't have physical addresses more than 44 bits (32 bit
pfn + 4k page size).

> Suggested by Andrew Cooper <andrew.cooper3@citrix.com> on lkml message
> <5569F9C9.8000607@citrix.com>.
> 
> The ifdef for ARM is ugly but did not find better solutions for it.

#ifdef __arm__

maybe?  Even if not, the unsightly parens are not necessary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
