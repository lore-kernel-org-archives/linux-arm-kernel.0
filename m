From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Jul 2014 09:26:47 +0200
Subject: [RFC PATCH 2/6] arm64: Support restart through restart notifier
 call chain
In-Reply-To: <1404155499-21177-3-git-send-email-linux@roeck-us.net>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
 <1404155499-21177-3-git-send-email-linux@roeck-us.net>
Message-ID: <20140701072647.GI28647@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 12:11:35PM -0700, Guenter Roeck wrote:
> The kernel core now supports a notifier call chain to restart the system.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/kernel/process.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 43b7c34..9dd2abd 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -43,6 +43,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/personality.h>
>  #include <linux/notifier.h>
> +#include <linux/watchdog.h>

I don't think you need this include, or shouldn't it be reboot.h
instead?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/c23e431a/attachment.sig>
