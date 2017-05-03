From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 21:14:13 +0800
Subject: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
 ls1012a/ls1046a/ls208xa
In-Reply-To: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20170503131408.GC24392@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 11:52:33AM +0800, Yangbo Lu wrote:
> This patch is to add eSDHC UHS-I/HS200 mode support for ls1012a/ls1046a/ls208xa.
> Because eSDHC is not a standard SD controller, the specific speed mode support
> depends on board's peripheral circuit for eSDHC. So, we have to add these speed
> modes support on board dts file.
> 
> In additon, these dts patches depends on esdhc driver patches which just had been merged
> on mmc.git. Otherwise, the UHS-I SD card and eMMC HS200 card would fail to be initialized,
> but other cards still could work fine.

So it sounds like just a new feature development which doesn't cause any
regression, even if driver and dts changes are merged independently.
For such case, we can just merge patches in their natural path
separately.

Shawn
