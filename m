From: robherring2@gmail.com (Rob Herring)
Date: Thu, 02 May 2013 14:39:11 -0500
Subject: [PATCH 4/4] ARM: highbank: fix build after cache flush change
In-Reply-To: <1367515404-512212-5-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
 <1367515404-512212-5-git-send-email-arnd@arndb.de>
Message-ID: <5182C0DF.9000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 12:23 PM, Arnd Bergmann wrote:
> Commit "ARM: cpu hotplug: remove majority of cache flushing from
> platforms" has removed the inclusion of asm/cacheflush.h from
> a number of files. Highbank still needs it because it calls
> flush_cache_louis().

AFAICT, the commit in question only showed up buried in a reply to
another thread and was never cc'ed to the relevant platform maintainers...

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---

I'd rather see the highbank changes dropped as this will all go away
with PSCI in 3.11, but:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

>  arch/arm/mach-highbank/hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
> index 80957f4..a019e4e 100644
> --- a/arch/arm/mach-highbank/hotplug.c
> +++ b/arch/arm/mach-highbank/hotplug.c
> @@ -14,6 +14,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  #include <linux/kernel.h>
> +#include <asm/cacheflush.h>
>  
>  #include "core.h"
>  #include "sysregs.h"
> 
