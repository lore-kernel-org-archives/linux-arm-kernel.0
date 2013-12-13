From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 13 Dec 2013 10:50:23 -0500
Subject: [PATCH v6 6/7] arm64, jump label: optimize jump label
 implementation
In-Reply-To: <20131213154104.GG19177@mudshark.cambridge.arm.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>
 <1386691433-6827-7-git-send-email-liuj97@gmail.com>
 <20131213154104.GG19177@mudshark.cambridge.arm.com>
Message-ID: <20131213105023.67e45640@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Dec 2013 15:41:04 +0000
Will Deacon <will.deacon@arm.com> wrote:

> > +#include <linux/kernel.h>
> > +#include <linux/jump_label.h>
> > +#include <asm/jump_label.h>
> > +#include <asm/insn.h>
> > +
> > +#ifdef HAVE_JUMP_LABEL
> 
> Slightly worrying... this should be CONFIG_HAVE_JUMP_LABEL, right? How did
> you manage to test this code?

In <linux/jump_label.h> we have:

#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)

[...]

# include <asm/jump_label.h>
# define HAVE_JUMP_LABEL
#endif	/* CC_HAVE_ASM_GOTO && CONFIG_JUMP_LABEL */


-- Steve
