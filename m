From: davem@davemloft.net (David Miller)
Date: Mon, 05 Nov 2012 20:25:01 -0500 (EST)
Subject: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
In-Reply-To: <1352155633-8648-16-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-16-git-send-email-walken@google.com>
Message-ID: <20121105.202501.1246122770431623794.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Lespinasse <walken@google.com>
Date: Mon,  5 Nov 2012 14:47:12 -0800

> Update the sparc32 arch_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Hmmm...

> -	if (flags & MAP_SHARED)
> -		addr = COLOUR_ALIGN(addr);
> -	else
> -		addr = PAGE_ALIGN(addr);

What part of vm_unmapped_area() is going to duplicate this special
aligning logic we need on sparc?
