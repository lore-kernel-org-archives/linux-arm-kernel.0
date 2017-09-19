From: thgarnie@google.com (Thomas Garnier)
Date: Tue, 19 Sep 2017 07:32:15 -0700
Subject: [PATCH] ARM: uaccess: Add missing include for set_thread_flag
In-Reply-To: <20170919115042.6800-1-net147@gmail.com>
References: <20170919115042.6800-1-net147@gmail.com>
Message-ID: <CAJcbSZEiHW=yH+ATvLq=am4nbVdhbqAxkH-+jEymhNkN+Pkb=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 4:50 AM, Jonathan Liu <net147@gmail.com> wrote:
> Fixes "implicit declaration of function" compile error for out-of-tree
> kernel modules including asm/uaccess.h.

I failed to reproduce this issue by creating an out of tree module
with a separate file (with only uaccess.h). Are you using a special
config?

Looking at the headers on uaccess.h. You get thread_info through:

 asm/domain.h -> asm/thread_info.h

>
> Fixes: 73ac5d6a2b6a ("arm/syscalls: Check address limit on user-mode return")
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  arch/arm/include/asm/uaccess.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 87936dd5d151..13d1877ffb75 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -17,6 +17,7 @@
>  #include <asm/unified.h>
>  #include <asm/compiler.h>
>
> +#include <linux/thread_info.h>
>  #include <asm/extable.h>
>
>  /*
> --
> 2.13.2
>



-- 
Thomas
