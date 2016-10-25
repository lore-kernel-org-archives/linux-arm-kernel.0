From: joe@perches.com (Joe Perches)
Date: Tue, 25 Oct 2016 11:05:09 -0700
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <CA+55aFw4EP_qxZ8tcRUV=PcLx_XbwXXOU_yp3cJHVjazof_0MA@mail.gmail.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej> <1477326477.1984.2.camel@perches.com>
 <20161024164255.GN15620@leverpostej>
 <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
 <CA+55aFw4EP_qxZ8tcRUV=PcLx_XbwXXOU_yp3cJHVjazof_0MA@mail.gmail.com>
Message-ID: <1477418709.1998.12.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-10-25 at 10:55 -0700, Linus Torvalds wrote:
> And yes, what we probably *should* do is to do the newline breaking
> when adding things to the log, rather than doing it in the
> "msg_print_text()" phase.

Yeah.

One thing that'd be nice one day is to remove all the
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
lines and have printk do that instead using a singleton
or a lookup for KBUILD_MODNAME as appropriate.

> There's a reason why I actually would have liked to entirely rewrite
> the whole printk mess.But there's also a reason I didn't - I'm not
> quite _that_ much of a glutton for punishment.

You sure?
