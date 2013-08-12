From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 12 Aug 2013 14:11:41 +0100
Subject: [PATCH V2] MFD: Make VEXPRESS MFD controller depends on
 VEXPRESS systems
In-Reply-To: <1376312115-10326-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375592514-14213-1-git-send-email-manjunath.goudar@linaro.org>
 <1376312115-10326-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376313101.13400.2.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-12 at 13:55 +0100, Manjunath Goudar wrote:
> This patch adds a of_find_node_by_phandle() and of_get_next_parent()
> function declaration dependence on"#ifdef CONFIG_OF" in "include/linux/of.h"
> else part return inline dummy implementations (returning NULL). Without
> this patch,build system can lead to issues. This was discovered during
> randconfig testing,in which VEXPRESS_CONFIG was enabled w/o CONFIG_OF
> being enabled,leading to the following error:
> 
> CC      drivers/mfd/vexpress-config.o
> drivers/mfd/vexpress-config.c: In function ?__vexpress_config_func_get?:
> drivers/mfd/vexpress-config.c:117:4: error: implicit declaration of function
> ?of_find_node_by_phandle? [-Werror=implicit-function-declaration]
>     bridge_node = of_find_node_by_phandle(
>     ^
> drivers/mfd/vexpress-config.c:117:16: warning: assignment makes pointer from
> integer without a cast [enabled by default]
>     bridge_node = of_find_node_by_phandle(
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Deepak Saxena <dsaxena@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> 
> V2:
>  -Made of_find_node_by_phandle() and of_get_next_parent() function declaration
>   dependence on"#ifdef CONFIG_OF" in "include/linux/of.h" instead of Kconfig
>   dependence setting in V1 patch and else part return inline dummy implementations
>   (returning NULL) to fix the above randconfig error.
> ---
>  include/linux/of.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

It's all cool, but the subject line doesn't make any sense now, does
it? ;-) As in: it's not a vexpress- nor mfd-related patch any more.

Pawel
