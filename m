From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Oct 2010 09:29:10 +0100
Subject: [PATCH] ARM: fix isb regression on CPU < v7
In-Reply-To: <1286308412-8252-1-git-send-email-linus.walleij@stericsson.com>
References: <1286308412-8252-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <002e01cb6530$8cfb8300$a6f28900$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> The kernel does not compile for my ARM926EJ-S system U300 due to
> the isb instruction inserted in generic assember statement from
> commit 8925ec4c530094b878e7e28a1fd78e7122afd973, "ARM: 6385/1:
> setup: detect aliasing I-cache when D-cache is non-aliasing"
> hey the isb is only available when assembling for v7 so let's
> use the generic isb() macro from setup.h instead.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---

Oops, well spotted! I suppose it's asking a bit much of the compiler
for it to optimise that case statement away when you're not building
for a v7 target :)

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
