From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 19:52:13 -0500
Subject: [PATCH v3 2/2] ARM: dove: split legacy and DT setup
In-Reply-To: <1359495695-29304-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130129212623.GJ7717@titan.lakedaemon.net>
 <1359495695-29304-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130131005213.GZ7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:41:35PM +0100, Sebastian Hesselbarth wrote:
> In the beginning of DT for Dove it was reasonable to have it close to
> non-DT code. With improved DT support, it became more and more difficult
> to not break non-DT while changing DT code.
> 
> This patch splits up DT board setup and introduces a DOVE_LEGACY config
> to allow to remove legacy code for DT-only kernels.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> [v3]
> - also include new board-dt.c file that was missing in v2 of patch [2/2]
>   (patch [1/2] has not changed and is not resent)
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-dove/Kconfig    |    5 ++
>  arch/arm/mach-dove/Makefile   |    4 +-
>  arch/arm/mach-dove/board-dt.c |  103 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/common.c   |   90 -----------------------------------
>  arch/arm/mach-dove/common.h   |    1 +
>  5 files changed, 112 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm/mach-dove/board-dt.c

Applied to mvebu/boards

thx,

Jason.
