From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 17:39:28 +0000
Subject: [RFC PATCH 0/3] introduce static_vm for ARM-specific static
 mapped area
In-Reply-To: <1352912154-16210-1-git-send-email-js1304@gmail.com>
References: <1352912154-16210-1-git-send-email-js1304@gmail.com>
Message-ID: <20121114173928.GK3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 01:55:51AM +0900, Joonsoo Kim wrote:
> In current implementation, we used ARM-specific flag, that is,
> VM_ARM_STATIC_MAPPING, for distinguishing ARM specific static mapped area.
> The purpose of static mapped area is to re-use static mapped area when
> entire physical address range of the ioremap request can be covered
> by this area.
> 
> This implementation causes needless overhead for some cases.

In what cases?

> We unnecessarily iterate vmlist for finding matched area even if there
> is no static mapped area. And if there are some static mapped areas,
> iterating whole vmlist is not preferable.

Why not?  Please put some explanation into your message rather than
just statements making unexplained assertions.

> Another reason for doing this work is for removing architecture dependency
> on vmalloc layer. I think that vmlist and vmlist_lock is internal data
> structure for vmalloc layer. Some codes for debugging and stat inevitably
> use vmlist and vmlist_lock. But it is preferable that they are used outside
> of vmalloc.c as least as possible.

The vmalloc layer is also made available for ioremap use, and it is
intended that architectures hook into this for ioremap support.
