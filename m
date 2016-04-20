From: mmarek@suse.cz (Michal Marek)
Date: Wed, 20 Apr 2016 10:38:17 +0200
Subject: [PATCH] kbuild: delete unnecessary "@:"
In-Reply-To: <1459422856-31754-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459422856-31754-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160420083817.GE15339@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 08:14:16PM +0900, Masahiro Yamada wrote:
> Since commit 2aedcd098a94 ('kbuild: suppress annoying "... is up to
> date." message'), $(call if_changed,...) is evaluated to "@:"
> when there is nothing to do.
> 
> We no longer need to add "@:" after $(call if_changed,...) to
> suppress "... is up to date." message.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/boot/Makefile                  | 1 -
>  arch/arm/boot/bootp/Makefile            | 1 -
>  arch/h8300/boot/compressed/Makefile     | 1 -
>  arch/m32r/boot/compressed/Makefile      | 1 -
>  arch/mn10300/boot/compressed/Makefile   | 1 -
>  arch/nios2/boot/compressed/Makefile     | 1 -
>  arch/s390/boot/compressed/Makefile      | 1 -
>  arch/sh/boot/compressed/Makefile        | 1 -
>  arch/sh/boot/romimage/Makefile          | 1 -
>  arch/unicore32/boot/compressed/Makefile | 1 -
>  arch/x86/boot/compressed/Makefile       | 1 -
>  arch/x86/purgatory/Makefile             | 2 --
>  arch/x86/realmode/rm/Makefile           | 1 -
>  13 files changed, 14 deletions(-)

Applied to kbuild.git#kbuild, thanks.

Michal
