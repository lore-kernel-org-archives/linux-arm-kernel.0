From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 19:58:48 +0000
Subject: [PATCH v2 0/5] mmp audio support
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201206131958.49446.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Zhangfei Gao wrote:
> 
> v1->v2:
> modify accroingly with suggestion from Vinod and Mark
> remove deprecated chan->private and dma.h
> remove prep_slave_sg
> remove module_init and move operation to probe
> misc change

It seems that this driver is missing DT bindings, which really need to get
added. The brownstone platform is currently supported using both DT and
ATAG probing, but we want to remove the ATAG variant eventually, so adding
a new driver for that platform without support for DT booting is a step in
the wrong direction.

	Arnd
