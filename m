From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 11:33:15 -0400
Subject: [PATCH v3 2/2] ARM: kirkwood: Add standby support
In-Reply-To: <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131001153315.GW31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 12:49:07PM -0300, Ezequiel Garcia wrote:
> Implements standby support for Kirkwood SoC. When the SoC enters
> standby state the memory PM units are disabled, the DDR is set
> in self-refresh mode, and the CPU is set in WFI.
> 
> At this point there's no clock gating, as that is considered each
> driver's task.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/Makefile                   |  2 +
>  arch/arm/mach-kirkwood/board-dt.c                 |  1 +
>  arch/arm/mach-kirkwood/common.c                   |  1 +
>  arch/arm/mach-kirkwood/common.h                   |  6 ++
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
>  arch/arm/mach-kirkwood/pm.c                       | 73 +++++++++++++++++++++++
>  6 files changed, 85 insertions(+)
>  create mode 100644 arch/arm/mach-kirkwood/pm.c

Applied to mvebu/soc

thx,

Jason.
