From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 19 Mar 2012 17:59:40 +0100
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
References: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120319165939.GB25144@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
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
>  #include <linux/linkage.h>
> +
>  #include <mach/io.h>
>  #include <mach/iomap.h>

I actually had a similar patch that looked pretty much like this:

	-#include <mach/io.h>
	+#include <asm/assembler.h>

The mach/io.h is no longer required AFAICT.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/5c60ee5f/attachment.sig>
