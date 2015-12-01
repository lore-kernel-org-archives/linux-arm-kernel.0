From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Dec 2015 10:31:43 +0100
Subject: [PATCH v3 10/10] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-11-git-send-email-james.morse@arm.com>
Message-ID: <20151201093143.GD21222@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
> before calling swsusp_save() to save the memory image.
> 
> Restore creates a set of temporary page tables, covering the kernel and the
> linear map, copies the restore code to a 'safe' page, then uses the copy to
> restore the memory image. It calls into cpu_resume(),
> and then follows the normal cpu_suspend() path back into the suspend code.
> 
> The implementation assumes that exactly the same kernel is booted on the
> same hardware, and that the kernel is loaded at the same physical address.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index 5faa3ce1fa3a..e75ad7aa268c 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -1,3 +1,5 @@
> +#include <linux/suspend.h>
> +
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>

Actually... even additional includes should go after the #ifdef
guards.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
