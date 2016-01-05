From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 18:01:02 +0000
Subject: [PATCH v9 08/13] arch/arm64: adopt prepare_exit_to_usermode()
 model from x86
In-Reply-To: <CALCETrUyB5dHn0OQwwYwB28pEDqMeGmnFv1mQLfHXhW-4YWCjg@mail.gmail.com>
References: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
 <1451936091-29247-9-git-send-email-cmetcalf@ezchip.com>
 <20160104203316.GE17127@leverpostej>
 <CALCETrUyB5dHn0OQwwYwB28pEDqMeGmnFv1mQLfHXhW-4YWCjg@mail.gmail.com>
Message-ID: <20160105180101.GA29455@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 02:31:42PM -0800, Andy Lutomirski wrote:
> On Mon, Jan 4, 2016 at 12:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > On Mon, Jan 04, 2016 at 02:34:46PM -0500, Chris Metcalf wrote:
> >> This change is a prerequisite change for TASK_ISOLATION but also
> >> stands on its own for readability and maintainability.
> >
> > I have also been looking into converting the userspace return path from
> > assembly to C [1], for the latter two reasons. Based on that, I have a
> > couple of comments.
> >
> 
> >
> > [1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm
> 
> Neat!
> 
> In case you want to compare notes, I have a branch with the entire
> syscall path on x86 in C except for cleanly separated asm fast path
> optimizations:
> 
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=x86/entry_compat

It was in fact your x86 effort that inspired me to look at this!

Thanks for the pointer, I'm almost certainly going to steal an idea or
two.

Currently it looks like arm64's conversion will be less painful than
that for x86 as the entry assembly is smaller and relatively uniform.
It looks like all but the register save/restore is possible in C.

That said, I have yet to stress/validate everything with tracing, irq
debugging, and so on, so my confidence may be misplaced.

Thanks,
Mark.
