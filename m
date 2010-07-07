From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Jul 2010 09:20:57 +0900
Subject: About cachetype on ARMv7
In-Reply-To: <20100705141719.GA23556@n2100.arm.linux.org.uk>
References: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
	<20100705141719.GA23556@n2100.arm.linux.org.uk>
Message-ID: <013501cb1d6a$47682ea0$d6388be0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Mon, Jul 05, 2010 at 08:21:56PM +0900, Kukjin Kim wrote:
> > If every ARMv7 SoCs have VIPT non-aliasing d-cache and i-cache, then no
> > problem. But actually, Samsung S5PV310(cortex-A9) has PIPT d-cache and
VIPT
> > non-aliasing i-cache. I think PIPT does not mean VIPT non-aliasing even
> > though their functionality is similar.
> 
> There is no visible difference between a non-aliasing VIPT cache and a
> PIPT cache.  Address bit allocation for a 32-byte cache line VIPT
> non-aliasing cache with 4K page size:
> 
> [0:1] = byte offset into word
> [4:2] = word offset
> [N-1:5] = virtual index
> [31:N] = physical tag
> 
> where N <= PAGE_SHIFT, otherwise it would be an aliasing VIPT cache.
> 
> For a PIPT non-aliasing cache:
> 
> [0:1] = byte offset into word
> [4:2] = word offset
> [M-1:5] = physical index
> [31:M] = physical tag
> 
> where M doesn't matter as it can never alias with itself.
> 
> The requirements for N is such the CPU visible conditions which qualify a
> cache as being VIPT non-aliasing also satisfy PIPT - and a non-aliasing
> VIPT cache has the same properties as a PIPT cache.

Thanks for your reply :-)

You mean PIPT is the same as VIPT non-aliasing.
Hmm..there is no need to show exactly cachetype in the kernel boot message?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
