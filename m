From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 13 Oct 2015 16:26:16 +0300
Subject: [PATCH] arm64: kasan: fix issues reported by sparse
In-Reply-To: <1444741266-21335-1-git-send-email-will.deacon@arm.com>
References: <1444741266-21335-1-git-send-email-will.deacon@arm.com>
Message-ID: <561D0678.2010609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 04:01 PM, Will Deacon wrote:
> Sparse reports some new issues introduced by the kasan patches:
> 
>   arch/arm64/mm/kasan_init.c:91:13: warning: no previous prototype for
>   'kasan_early_init' [-Wmissing-prototypes] void __init kasan_early_init(void)
>              ^
>   arch/arm64/mm/kasan_init.c:91:13: warning: symbol 'kasan_early_init'
>   was not declared. Should it be static? [sparse]
> 
> This patch resolves the problem by adding a prototype for
> kasan_early_init and marking the function as asmlinkage, since it's only
> called from head.S.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
