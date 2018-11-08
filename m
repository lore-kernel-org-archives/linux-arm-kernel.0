From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 8 Nov 2018 15:48:10 +0100
Subject: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
Message-ID: <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

[...]

> Changes in v8:
> - Rebased onto 65102238 (4.20-rc1).
> - Added a note to the cover letter on why syscall wrappers/shims that untag
>   user pointers won't work.
> - Added a note to the cover letter that this patchset has been merged into
>   the Pixel 2 kernel tree.
> - Documentation fixes, in particular added a list of syscalls that don't
>   support tagged user pointers.

Hi Catalin,

I've changed the documentation to be more specific, please take a look.

I haven't done anything about adding a way for the user to find out
that the kernel supports this ABI extension. I don't know what would
the the preferred way to do this, and we haven't received any comments
on that from anybody else. Probing "on some innocuous syscall
currently returning -EFAULT on tagged pointer arguments" works though,
as you mentioned.

As mentioned in the cover letter, this patchset has been merged into
the Pixel 2 kernel tree.

Thanks!
