From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 27 Jan 2013 21:19:27 -0500
Subject: [PATCH 1/3] ARM: Dove: split legacy and DT setup
In-Reply-To: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130128021927.GH1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 01:24:27AM +0100, Sebastian Hesselbarth wrote:
> In the beginning of DT for Dove it was reasonable to have it close to
> non-DT code. With improved DT support, it became more and more difficult
> to not break non-DT while changing DT code.
> 
> This patch splits up DT board setup and introduces a DOVE_LEGACY config
> to allow to remove legacy code for DT-only kernels.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-dove/Kconfig    |    5 ++
>  arch/arm/mach-dove/Makefile   |    4 +-
>  arch/arm/mach-dove/board-dt.c |  102 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/common.c   |   85 ----------------------------------
>  4 files changed, 110 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm/mach-dove/board-dt.c

Applied to mvebu/boards

thx,

Jason.
