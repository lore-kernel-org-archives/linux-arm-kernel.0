From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 22 Apr 2016 10:11:19 -0500
Subject: [PATCH] ARM: SoCFPGA: simplify secondary trampoline
In-Reply-To: <1461221580-27466-1-git-send-email-s.hauer@pengutronix.de>
References: <1461221580-27466-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <571A3F17.6000701@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2016 01:53 AM, Sascha Hauer wrote:
> The secondary CPU startup trampoline goes through the system managers
> cpu1start_addr register. This seems unnecesary, the trampoline code
> can be simplified by directly loading the program counter with the
> address of secondary_startup(). Taken from the Rockchip code which
> does it exactly like this. While at it add a socfpga_ namespace to
> the trampoline functions.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-socfpga/core.h    |  4 ++--
>  arch/arm/mach-socfpga/headsmp.S | 27 +++++++---------------
>  arch/arm/mach-socfpga/platsmp.c | 51 +++++++++++++++++++----------------------
>  arch/arm/mach-socfpga/socfpga.c |  9 --------
>  4 files changed, 33 insertions(+), 58 deletions(-)
> 

Applied!

Thanks,
Dinh
