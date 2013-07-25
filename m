From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 25 Jul 2013 15:31:43 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space
In-Reply-To: <84d9a3ae9ab7a47924eb54934dcad91339543d63.1373036932.git.afzal@ti.com>
References: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
 <84d9a3ae9ab7a47924eb54934dcad91339543d63.1373036932.git.afzal@ti.com>
Message-ID: <51F0F787.9030108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/5/2013 8:43 PM, Afzal Mohammed wrote:
> Register target address to be used for cpgmac is the second device
> address space. By default, hwmod picks first address space (0th index)
> for register target.
>
> With removal of address space from hwmod and using DT instead, cpgmac
> is getting wrong address space for register target.
>
> Fix it by indicating the address space to be used for register target.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
I have tested this patch and it's needed when we have CPSW Ethernet built-in to
go to low power state.

Tested-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
