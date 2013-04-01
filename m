From: keescook@chromium.org (Kees Cook)
Date: Mon, 1 Apr 2013 14:53:09 -0700
Subject: [PATCH V2 1/3] seccomp: add generic code for jitted seccomp
 filters.
In-Reply-To: <1363618233-6375-2-git-send-email-nschichan@freebox.fr>
References: <1363618233-6375-1-git-send-email-nschichan@freebox.fr>
 <1363618233-6375-2-git-send-email-nschichan@freebox.fr>
Message-ID: <CAGXu5j+jpXrcLDyAV+p81pjapaQeKQTMz4+JXjKj03DV-yoC=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 7:50 AM, Nicolas Schichan <nschichan@freebox.fr> wrote:
> Architecture must select HAVE_SECCOMP_FILTER_JIT and implement
> seccomp_jit_compile() and seccomp_jit_free() if they intend to support
> jitted seccomp filters.
>
> struct seccomp_filter has been moved to <linux/seccomp.h> to make its
> content available to the jit compilation code.
>
> In a way similar to the net BPF, the jit compilation code is expected
> to updates struct seccomp_filter.bpf_func pointer to the generated
> code.
>
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Acked-by: Kees Cook <keescook@chromium.org>

I'd love to see this for x86 too. I suspect it'd be a small change
after this series lands.

Thanks,

-Kees

-- 
Kees Cook
Chrome OS Security
