From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 09:34:45 +0900
Subject: [RFC 08/17] ARM: shmobile: r8a7779: Add helper to read mode pins
In-Reply-To: <52933A35.7070206@cogentembedded.com>
References: <1385342312-1967-1-git-send-email-horms+renesas@verge.net.au>
 <1385342312-1967-9-git-send-email-horms+renesas@verge.net.au>
 <52933A35.7070206@cogentembedded.com>
Message-ID: <20131126003445.GI15227@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:53:25PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-11-2013 5:18, Simon Horman wrote:
> 
> >Add and use helper to read mode pins.
> >This will be re-used when moving marzen-reference to
> >the common clock framework.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/clock-r8a7779.c        | 11 ++---------
> >  arch/arm/mach-shmobile/include/mach/r8a7779.h |  1 +
> >  arch/arm/mach-shmobile/setup-r8a7779.c        | 14 ++++++++++++++
> >  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> >diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> >index b7ce0e7..decf122 100644
> >--- a/arch/arm/mach-shmobile/clock-r8a7779.c
> >+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> [...]
> >diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> >index 8f94531..4e3fbfb 100644
> >--- a/arch/arm/mach-shmobile/setup-r8a7779.c
> >+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> >@@ -874,6 +874,20 @@ void __init r8a7779_add_standard_devices_dt(void)
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >  }
> >
> >+#define MODEMR		0xffcc0020
> >+
> >+u32 __init r8a7779_read_mode_pins(void)
> >+{
> >+	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
> 
>    Why waste 2 4K pages if you're only interested in 4 bytes (i.e. 1
> page)? I remember I've already asked that question...

I don't recall if there was a conclusion to that discussion.

In any case, this patch just shuffles code around.
