From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 15 Oct 2017 16:47:16 +0900
Subject: [PATCH 0/3] ARM, hexagon, c6x: build: fix usage of CFLAGS_MODULE,
 LDFLAGS_MODULE
In-Reply-To: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATsU=tfgDJ6KjmqK7DwcKRL3DrvOPhP9Umn81zRKEO73g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-09 23:35 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> CFLAGS_MODULE, AFLAGS_MODULE, and LDFLAGS_MODULE are supposed
> to be set by users.
>
> In-kernel Makefile must use KBUILD_ prefixed variables.
>
> This is explained in Documentation/kbuild/{kbuild.txt, makefiles.txt}
>
> Most of architectures follow the rule, but I found violations
> in ARM, hexagone, and c6x.
>
> Fix them.
>
>
>
> Masahiro Yamada (3):
>   ARM: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
>   hexagon: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
>   c6x: add KBUILD_ prefix to CFLAGS_MODULE
>
>  arch/arm/Makefile     | 6 +++---
>  arch/c6x/Makefile     | 2 +-
>  arch/hexagon/Makefile | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
>

Series, applied to linux-kbuild/kbuild.



-- 
Best Regards
Masahiro Yamada
