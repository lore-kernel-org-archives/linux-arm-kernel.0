From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 12:08:30 +0000
Subject: [PATCH v3 5/5] zynq: move static peripheral mappings
In-Reply-To: <20121024003523.GF31625@beefymiracle.amer.corp.natinst.com>
References: <20121024003523.GF31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210241208.30768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Josh Cartwright wrote:
> Shifting them up into the vmalloc region prevents the following warning,
> when booting a zynq qemu target with more than 512mb of RAM:
> 
>   BUG: mapping for 0xe0000000 at 0xe0000000 out of vmalloc space
> 
> In addition, it allows for reuse of these mappings when the proper
> drivers issue requests via ioremap().
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
