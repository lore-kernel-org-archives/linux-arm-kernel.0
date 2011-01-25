From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 26 Jan 2011 07:37:13 +0800
Subject: [PATCH v3] Add i.MX23/28 auart support
In-Reply-To: <1295863436-16663-1-git-send-email-s.hauer@pengutronix.de>
References: <1295863436-16663-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110125233712.GA1146@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 11:03:54AM +0100, Sascha Hauer wrote:
> changes since v2:
> - Fix console support
> - For handling the CREAD flag just disable the receiver instead of
>   ignoring the characters in the receive interrupt
> - Add timeout to loops in console support
> 
> The following changes since commit 0c21e3aaf6ae85bee804a325aa29c325209180fd:
> 
>   Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hch/hfsplus (2011-01-07 17:16:27 -0800)
> 
> are available in the git repository at:
> 
>   nowhere ..BRANCH.NOT.VERIFIED..
> 
> Sascha Hauer (2):
>       serial: Add auart driver for i.MX23/28
>       ARM MXS: Add auart platform support for i.MX28
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |    5 +
>  arch/arm/mach-mxs/devices-mx28.h                |    8 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-auart.c      |   54 ++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   10 +
>  drivers/serial/Kconfig                          |   15 +
>  drivers/serial/Makefile                         |    1 +
>  drivers/serial/mxs-auart.c                      |  799 +++++++++++++++++++++++
>  9 files changed, 896 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
>  create mode 100644 drivers/serial/mxs-auart.c
> 
> 
Tested-by: Shawn Guo <shawn.guo@freescale.com>
