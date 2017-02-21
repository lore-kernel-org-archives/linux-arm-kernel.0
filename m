From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 21 Feb 2017 15:41:27 +0530
Subject: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
In-Reply-To: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
References: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
Message-ID: <f8862417-e9e0-e2ac-865a-9684f96a5128@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2017 03:30 PM, Sekhar Nori wrote:
> From: Schuyler Patton <spatton@ti.com>
> 
> AM571x IDK and the AM572x IDK use CAN1 interface.
> This patch enables it for both boards.
> 
> Tested on AM572x IDK using cansequence.
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> [nsekhar at ti.com: move to use DRA7XX_CORE_IOPAD())
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I should have noted that although CAN does function on the IDK with this
patch, there are "omap_hwmod: dcan1: _wait_target_disable failed"
messages that come up due to lack of workaround for errata i893[1]

Roger does have some patches to workaround that errata. If you want to
wait for those patches to be submitted and accepted first, it should be
fine as well.

Thanks,
Sekhar

[1] http://www.ti.com/lit/er/sprz436b/sprz436b.pdf
