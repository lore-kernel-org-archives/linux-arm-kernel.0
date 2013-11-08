From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 14:43:08 +0000
Subject: [PATCH 2/4] arm64: Add audit support
In-Reply-To: <1383733546-2846-3-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1383733546-2846-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20131108144307.GK17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:25:44AM +0000, AKASHI Takahiro wrote:
> diff --git a/arch/arm64/kernel/audit.c b/arch/arm64/kernel/audit.c
> new file mode 100644
> index 0000000..9aab2b3
> --- /dev/null
> +++ b/arch/arm64/kernel/audit.c
> @@ -0,0 +1,59 @@
> +#include <linux/audit.h>
> +#include <linux/init.h>
> +#include <asm/unistd.h>
> +
> +static unsigned dir_class[] = {
> +#include <asm-generic/audit_dir_write.h>
> +~0U
> +};
> +
> +static unsigned read_class[] = {
> +#include <asm-generic/audit_read.h>
> +~0U
> +};
> +
> +static unsigned write_class[] = {
> +#include <asm-generic/audit_write.h>
> +~0U
> +};
> +
> +static unsigned chattr_class[] = {
> +#include <asm-generic/audit_change_attr.h>
> +~0U
> +};
> +
> +static unsigned signal_class[] = {
> +#include <asm-generic/audit_signal.h>
> +~0U
> +};

This looks like a copy of lib/audit.c to me. Why can't we use that instead?

Will
