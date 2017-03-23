From: keescook@chromium.org (Kees Cook)
Date: Thu, 23 Mar 2017 13:15:08 -0700
Subject: [PATCH v5 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170323172515.27950-1-thgarnie@google.com>
References: <20170323172515.27950-1-thgarnie@google.com>
Message-ID: <CAGXu5jKbqOvb2TtfpXhjPQFxEShaBu=RbBQORtqhcF1bD3As6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 10:25 AM, Thomas Garnier <thgarnie@google.com> wrote:
> This patch ensures a syscall does not return to user-mode with a kernel
> address limit. If that happened, a process can corrupt kernel-mode
> memory and elevate privileges.
>
> For example, it would mitigation this bug:
>
> - https://bugs.chromium.org/p/project-zero/issues/detail?id=990
>
> The CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE option is also
> added so each architecture can optimize this change.
>
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Awesome. :) I've tested this on x86 and arm with the LKDTM patch I'll
post in a moment.

[   46.977823] lkdtm: Performing direct entry CORRUPT_USER_DS
[   46.978966] lkdtm: setting bad task size limit
[   46.980302] ------------[ cut here ]------------
[   46.981219] kernel BUG at ./include/linux/syscalls.h:200!

Tested-by: Kees Cook <keescook@chromium.org>

(Also note, your Signed-off-by lines are missing in patches 2-4)

-- 
Kees Cook
Pixel Security
