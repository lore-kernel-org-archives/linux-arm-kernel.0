From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 2 Aug 2016 16:58:29 -0400
Subject: Please don't replace numeric parameter like 0444 with macro
Message-ID: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ So I answered similarly to another patch, but I'll just re-iterate
and change the subject line so that it stands out a bit from the
millions of actual patches ]

On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> S_IRCRP | S_IROTH (*). Please don't do this.

Absolutely. It's *much* easier to parse and understand the octal
numbers, while the symbolic macro names are just random line noise and
hard as hell to understand. You really have to think about it.

So we should rather go the other way: convert existing bad symbolic
permission bit macro use to just use the octal numbers.

The symbolic names are good for the *other* bits (ie sticky bit, and
the inode mode _type_ numbers etc), but for the permission bits, the
symbolic names are just insane crap. Nobody sane should ever use them.
Not in the kernel, not in user space.

           Linus
