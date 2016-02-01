From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Feb 2016 15:20:15 +0000
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <56A84748.3040108@oracle.com>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com>
Message-ID: <20160201152015.GU10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 08:27:52PM -0800, santosh.shilimkar at oracle.com wrote:
> On 1/26/16 10:21 AM, Russell King wrote:
> >Make virt_to_idmap() return an unsigned long rather than phys_addr_t.
> >
> >Returning phys_addr_t here makes no sense, because the definition of
> >virt_to_idmap() is that it shall return a physical address which maps
> >identically with the virtual address.  Since virtual addresses are
> >limited to 32-bit, identity mapped physical addresses are as well.
> >
> >Almost all users already had an implicit narrowing cast to unsigned long
> >so let's make this official and part of this interface.
> >
> >Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >---
> Looks correct to me.
> 
> Vitaly,
> Could you please try out this patch and see everything continue to
> work ?

I haven't heard anything yet...  Vitaly?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
