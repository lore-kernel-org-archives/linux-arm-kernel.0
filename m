From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 23 Jan 2017 18:54:35 +0900
Subject: [PATCH] iopoll: include <linux/ktime.h> instead of
 <linux/hrtimer.h>
In-Reply-To: <1481679225-10885-1-git-send-email-yamada.masahiro@socionext.com>
References: <1481679225-10885-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARt_yDHJo4XW_ENt=nH10En10crJPV8oMc=G04WmRG6Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2016-12-14 10:33 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The timer APIs this header needs are ktime_get(), ktime_add_us(),
> and ktime_compare().  So, including <linux/ktime.h> seems enough.
> This commit will cut unnecessary header file parsing.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


No comment for this patch?

Will,
Could you check this patch, please?



>
> I was not quite sure whom I should send this patch to.
> I am sending this to Will Deacon because commit 54c523127bcc
> ("iopoll: Introduce memory-mapped IO polling macros") was applied
> by him.
>
>
>  include/linux/iopoll.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 1c30014..d29e1e2 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -17,7 +17,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/hrtimer.h>
> +#include <linux/ktime.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
