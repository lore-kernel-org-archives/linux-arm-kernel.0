From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Tue, 26 Jan 2016 20:27:52 -0800
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
Message-ID: <56A84748.3040108@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/26/16 10:21 AM, Russell King wrote:
> Make virt_to_idmap() return an unsigned long rather than phys_addr_t.
>
> Returning phys_addr_t here makes no sense, because the definition of
> virt_to_idmap() is that it shall return a physical address which maps
> identically with the virtual address.  Since virtual addresses are
> limited to 32-bit, identity mapped physical addresses are as well.
>
> Almost all users already had an implicit narrowing cast to unsigned long
> so let's make this official and part of this interface.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Looks correct to me.

Vitaly,
Could you please try out this patch and see everything continue to
work ?

Regards,
Santosh
