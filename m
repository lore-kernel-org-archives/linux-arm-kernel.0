From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 29 Aug 2013 10:38:16 -0500
Subject: [PATCH RFC v2 11/16] ARM: socfpga: remove call to of_clk_init
In-Reply-To: <1377638890-371-12-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-12-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377790696.26261.3.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-27 at 23:28 +0200, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove mach specific calls to it.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-socfpga/socfpga.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index bfce964..dd0d49c 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -14,7 +14,6 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> -#include <linux/clk-provider.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -107,7 +106,6 @@ static void __init socfpga_cyclone5_init(void)
>  {
>  	l2x0_of_init(0, ~0UL);
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	of_clk_init(NULL);
>  	socfpga_init_clocks();
>  }
>  

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
