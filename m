From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 22 Nov 2010 07:25:59 +0100
Subject: [PATCH] mv78xx: wrong cpu1 window base register address
In-Reply-To: <20101109194617.GA14544@maclin>
References: <20101109194617.GA14544@maclin>
Message-ID: <20101122062559.GA29997@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 10:46:18PM +0300, Evgeniy Dushistov wrote:

> The constant DDR_WINDOW_CPU1_BASE has wrong value.
> Because of that mv78xx0_mbus_dram_info is not filled properly on
> start, and in its turn drivers, that used mv78xx0_mbus_dram_info,
> in my case mv643xx_eth.c, not work on second core.
> According to
> 
> MV76100, MV78100, and MV78200 DiscoveryTM Innovation Series
> CPU Family
> Functional Specifications
> 
> address should be 0x1570.
> 
> Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
