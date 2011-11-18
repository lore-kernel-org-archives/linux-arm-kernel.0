From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 18 Nov 2011 10:04:00 +0000
Subject: [PATCH 0/23] mach/vmalloc.h removal, and ioremap optimization
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <20111118100400.GB8023@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 12:48:18AM -0500, Nicolas Pitre wrote:
> This patch series removes all instances of mach/vmalloc.h in order to
> have a more unified memory map across all ARM architectures.  To do so,
> the static mappings are moved inside the vmalloc area.  And finally this
> allows for a generic optimization to ioremap where static mappings are
> reused whenever possible, using common code instead of having this
> duplicated in a couple places.
> 
> This series provides a net reduction of more than 1200 lines of code.
> 
> One regression was discovered on shmobile during testing because that
> platform asks for 158MB of consistent DMA memory while the documented
> maximum is 14MB.  Inspection of the code doesn't tell why this is
> required, and listed maintainers did not respond yet, two months
> after repeated inquiries.  So a temporary exception to the definition
> of VMALLOC_END was added for CONFIG_SHMOBILE and a noisy warning to
> get those maintainers' attention.
> 
> This patch series was initially submitted for inclusion for v3.1, and
> withdrawn due to too many problems found on OMAP.  Those problems are
> now fixed in current mainline.  This is therefore rebased on v3.2-rc2.

Works great on picoxcell.  Thanks Nicolas!

Tested-by: Jamie Iles <jamie@jamieiles.com>
