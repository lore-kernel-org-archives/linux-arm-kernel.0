From: keescook@chromium.org (Kees Cook)
Date: Wed, 25 Feb 2015 14:17:55 -0800
Subject: [PATCH 0/3] CONFIG_DEBUG_SET_MODULE_RONX fixups
In-Reply-To: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
References: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAGXu5jKKn1f7bnp3Ezsc3o_iqV19Gu62-83ub3s7Rwu=oK7kBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 2:14 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> Hi,
>
> CONFIG_DEBUG_SET_MODULE_RONX is currently non-functional on arm and arm64
> because of changes in behavior of is_module_addr. This series fixes
> both arm and arm64 to work correctly and corrects a minor bug
> related to section alignment in modules.
>
> Laura Abbott (3):
>   arm64: Don't use is_module_addr in setting page attributes
>   arm: Don't use is_module_addr in setting page attributes
>   kernel/module.c: Update debug alignment after symtable generation
>
>  arch/arm/mm/pageattr.c   | 5 ++++-
>  arch/arm64/mm/pageattr.c | 5 ++++-
>  kernel/module.c          | 2 ++
>  3 files changed, 10 insertions(+), 2 deletions(-)

Thanks for fixing this!

Out of curiosity, which change broke DEBUG_SET_MODULE_RONX ? (i.e.
does this need a CC: stable, and if so, through which release?)

Regardless, consider them:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
