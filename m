From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Mar 2012 11:54:14 -0500
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
References: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F6764B6.6050109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 11:50 AM, Stephen Warren wrote:
> Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
> IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
> sleep.S to do so.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  arch/arm/mach-tegra/sleep.S |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
> index 8f9fde1..48cc7c6 100644
> --- a/arch/arm/mach-tegra/sleep.S
> +++ b/arch/arm/mach-tegra/sleep.S
> @@ -22,7 +22,10 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
>  
> +#include <asm/assembler.h>
> +

Is there some reason you put this before linux/ include?

>  #include <linux/linkage.h>
> +
>  #include <mach/io.h>
>  #include <mach/iomap.h>
>  
