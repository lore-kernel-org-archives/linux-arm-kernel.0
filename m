From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 Aug 2013 21:24:38 -0700
Subject: [PATCH] ARM: fiq: Cast the first argument of flush_icache_range()
In-Reply-To: <1376613333-7021-1-git-send-email-festevam@gmail.com>
References: <1376613333-7021-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOesGMgi3f4sYN9S7ywXqbLEjYaGcNCQ+_YTQYkv-UegunaZeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 5:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Commit 2ba85e7af4 (ARM: Fix FIQ code on VIVT CPUs) causes the following build
> warning:
>
> arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
> arch/arm/kernel/fiq.c:92:3: warning: passing argument 1 of 'cpu_cache.coherent_kern_range' makes integer from pointer without a cast [enabled by default]
> arch/arm/kernel/fiq.c:92:3: note: expected 'long unsigned int' but argument is of type 'void *'
>
> Cast it as '(unsigned long)base' to avoid the warning.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Olof Johansson <olof@lixom.net>

This warning just showed up on mainline with the last arm fixes.
Please send to the patch tracker.


-Olof
