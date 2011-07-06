From: david@lang.hm (david at lang.hm)
Date: Wed, 6 Jul 2011 13:20:55 -0700 (PDT)
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <CAOJsxLHQP=-srK_uYYBsPb7+rUBnPZG7bzwtCd-rRaQa4ikUFg@mail.gmail.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com>
	<CAOJsxLHQP=-srK_uYYBsPb7+rUBnPZG7bzwtCd-rRaQa4ikUFg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1107061318190.2535@asgard.lang.hm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Pekka Enberg wrote:

> Why does the allocator need to know about address boundaries? Why
> isn't it enough to make the page allocator and reclaim policies favor using
> memory from lower addresses as aggressively as possible? That'd mean
> we'd favor the first memory banks and could keep the remaining ones
> powered off as much as possible.
>
> IOW, why do we need to support scenarios such as this:
>
>   bank 0     bank 1   bank 2    bank3
> | online  | offline | online  | offline |

I believe that there are memory allocations that cannot be moved after 
they are made (think about regions allocated to DMA from hardware where 
the hardware has already been given the address space to DMA into)

As a result, you may not be able to take bank 2 offline, so your option is 
to either leave banks 0-2 all online, or support emptying bank 1 and 
taking it offline.

David Lang
