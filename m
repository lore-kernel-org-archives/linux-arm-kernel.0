From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 4 Jan 2016 14:31:42 -0800
Subject: [PATCH v9 08/13] arch/arm64: adopt prepare_exit_to_usermode()
 model from x86
In-Reply-To: <20160104203316.GE17127@leverpostej>
References: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
 <1451936091-29247-9-git-send-email-cmetcalf@ezchip.com>
 <20160104203316.GE17127@leverpostej>
Message-ID: <CALCETrUyB5dHn0OQwwYwB28pEDqMeGmnFv1mQLfHXhW-4YWCjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2016 at 12:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Mon, Jan 04, 2016 at 02:34:46PM -0500, Chris Metcalf wrote:
>> This change is a prerequisite change for TASK_ISOLATION but also
>> stands on its own for readability and maintainability.
>
> I have also been looking into converting the userspace return path from
> assembly to C [1], for the latter two reasons. Based on that, I have a
> couple of comments.
>

>
> [1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm

Neat!

In case you want to compare notes, I have a branch with the entire
syscall path on x86 in C except for cleanly separated asm fast path
optimizations:

https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=x86/entry_compat

Even in Linus' tree, the x86 32-bit syscalls are in C.
