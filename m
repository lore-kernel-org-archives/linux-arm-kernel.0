From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 28 Jan 2018 10:41:42 +0900
Subject: [PATCH] kbuild: fix W= option checks for extra DTC warnings
In-Reply-To: <1516246306-12851-1-git-send-email-yamada.masahiro@socionext.com>
References: <1516246306-12851-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASbdy99XO712fpEW0j-wTPyMZCEuCrAOjJae2iuORut2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-18 12:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Kbuild supports 3 levels of extra warnings, and multiple levels can
> be combined, like W=12, W=123.  It was added by commit a6de553da01c
> ("kbuild: Allow to combine multiple W= levels").
>
> From the log of commit 8654cb8d0371 ("dtc: update warning settings
> for new bus and node/property name checks"), I assume:
>
>  - unit_address_vs_reg, simple_bus_reg, etc. belong to level 1
>  - node_name_chars_strict, property_name_chars_strict belong to level 2
>
> However, the level 1 warnings are displayed by any argument to W=.
> On the other hand, the level 2 warnings are displayed by W=2, but
> not by W=12, or W=123.
>
> Use $(findstring ...) like scripts/Makefile.extrawarn.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.


-- 
Best Regards
Masahiro Yamada
