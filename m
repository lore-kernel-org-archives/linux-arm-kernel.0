From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 10:02:45 +0000
Subject: [PATCH] ARM: Fix build break on ARM v6 and v7
In-Reply-To: <1261125427-17517-1-git-send-email-gadiyar@ti.com>
References: <1261125427-17517-1-git-send-email-gadiyar@ti.com>
Message-ID: <20091218100245.GA29296@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 02:07:07PM +0530, Anand Gadiyar wrote:
> Commit 2c9b9c849 added an argument to __cpuc_flush_dcache_page
> and renamed it.
> 
> Update a caller of the old function to fix this build error:
> 
>   CC      arch/arm/mm/copypage-v6.o
> arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> make[1]: *** [arch/arm/mm/copypage-v6.o] Error 1
> make: *** [arch/arm/mm] Error 2
> 
> 
> Reported-by: Jinsung Yang <jsgood.yang@samsung.com>
> NYET-Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> Russell,
> 
> I fixed this almost independently at roughly the same time as your
> mail on the list. Do I still get credit for the patch?

Patch is good.  If you want to convert the NYET-sob to a proper
signed-off-by, and throw it at the patch system...
