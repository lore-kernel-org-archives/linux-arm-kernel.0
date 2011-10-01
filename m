From: rabin@rab.in (Rabin Vincent)
Date: Sun, 2 Oct 2011 00:34:45 +0530
Subject: [PATCH] Add missing include of linux/ftrace.h
In-Reply-To: <20111001171202.GA13684@gallagher>
References: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
	<20111001163511.GI11710@n2100.arm.linux.org.uk>
	<20111001171202.GA13684@gallagher>
Message-ID: <CAH+eYFBESAp8Hz6fBAqjWSgAkzPuAub4JqU4r3SDU+TQTRagBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 1, 2011 at 22:42, Jamie Iles <jamie@jamieiles.com> wrote:
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index de3dcab..61c1468 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -37,6 +37,7 @@
> ?#include <linux/proc_fs.h>
> ?#include <linux/ftrace.h>

You can probably git rid of this inclusion of ftrace.h from
here and from smp.c, because they were added only for
__exception_irq_entry.

>
> +#include <asm/exception.h>
> ?#include <asm/system.h>
> ?#include <asm/mach/arch.h>
> ?#include <asm/mach/irq.h>
