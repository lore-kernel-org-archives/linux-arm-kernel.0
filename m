From: rostedt@goodmis.org (Steven Rostedt)
Date: Sun, 28 Oct 2018 14:09:11 -0400
Subject: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
In-Reply-To: <20181028130945.23581-2-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
Message-ID: <20181028140911.21d49629@vmware.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2018 13:09:42 +0000
Changbin Du <changbin.du@gmail.com> wrote:

> The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> So declare check_la57_support() as inline to make sure the code
> referring to level4_kernel_pgt is optimized out. This is a preparation
> for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  arch/x86/kernel/head64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 5dc377dc9d7b..5ae682f2aa83 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -98,7 +98,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>  	return true;
>  }
>  #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static inline bool __head check_la57_support(unsigned long physaddr)
>  {
>  	return false;
>  }
