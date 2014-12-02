From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 02 Dec 2014 16:23:57 +0100
Subject: [PATCH 3/3] clk: samsung: remove unnecessary inclusion of header
 files from clk.h
In-Reply-To: <1411796519-19417-4-git-send-email-pankaj.dubey@samsung.com>
References: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
 <1411796519-19417-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <547DD98D.3000101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 27/09/14 07:41, Pankaj Dubey wrote:
> Let's remove unnecessary include of header files from clk.h and add
> required one in clk.c
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/clk/samsung/clk.c |    3 ++-
>  drivers/clk/samsung/clk.h |    4 ----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index 31bf391..952f9ec 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -11,7 +11,8 @@
>   * clock framework for Samsung platforms.
>  */
>  
> -#include <linux/syscore_ops.h>

I've dropped this change when applying since it causes a build break:

drivers/clk/samsung/clk.c:338:15: error: variable ?samsung_clk_syscore_ops? has initializer but incomplete type
drivers/clk/samsung/clk.c:339:2: error: unknown field ?suspend? specified in initializer
drivers/clk/samsung/clk.c:339:2: warning: excess elements in struct initializer [enabled by default]
drivers/clk/samsung/clk.c:339:2: warning: (near initialization for ?samsung_clk_syscore_ops?) [enabled by default]
drivers/clk/samsung/clk.c:340:2: error: unknown field ?resume? specified in initializer
drivers/clk/samsung/clk.c:340:2: warning: excess elements in struct initializer [enabled by default]
drivers/clk/samsung/clk.c:340:2: warning: (near initialization for ?samsung_clk_syscore_ops?) [enabled by default]  CC      drivers/dma/virt-dma.o

drivers/clk/samsung/clk.c: In function ?samsung_clk_sleep_init?:
drivers/clk/samsung/clk.c:359:3: error: implicit declaration of function ?register_syscore_ops? [-Werror=implicit-function-declaration]

Please make sure there is no build breaks with various configs when
sending patches.

--
Regards,
Sylwester
