From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Oct 2013 11:34:10 -0700
Subject: [RFC] ARM: tty: Move HVC DCC assembly to arch/arm
In-Reply-To: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
References: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
Message-ID: <52617F22.6030900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/13 11:14, Christopher Covington wrote:
> Put architecture-specific assembly code where it belongs,
> allowing for support of additional architectures such as arm64 in
> the future.

Do you have that patch too? There was also a patch a year ago to add
armv5/v4 support to this driver. Maybe we can resurrect that too.

> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 44fbeba..e9f0191 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -8,57 +8,13 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
>   */
>  
> -#include <linux/console.h>
> -#include <linux/delay.h>
> -#include <linux/err.h>
> -#include <linux/init.h>

We still need init.h

> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -
> +#include <asm/dcc.h>
>  #include <asm/processor.h>
>  
>  #include "hvc_console.h"
>  
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
