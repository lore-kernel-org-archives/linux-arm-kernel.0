From: wad@chromium.org (Will Drewry)
Date: Thu, 4 Apr 2013 14:58:46 -0500
Subject: [PATCH V2 1/3] seccomp: add generic code for jitted seccomp
 filters.
In-Reply-To: <CAGXu5j+jpXrcLDyAV+p81pjapaQeKQTMz4+JXjKj03DV-yoC=w@mail.gmail.com>
References: <1363618233-6375-1-git-send-email-nschichan@freebox.fr>
 <1363618233-6375-2-git-send-email-nschichan@freebox.fr>
 <CAGXu5j+jpXrcLDyAV+p81pjapaQeKQTMz4+JXjKj03DV-yoC=w@mail.gmail.com>
Message-ID: <CABqD9hZp7FiQjvLrauV1rkUqgXZyCxmbOKA+6rzpDNEEfJ0NPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 1, 2013 at 4:53 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Mar 18, 2013 at 7:50 AM, Nicolas Schichan <nschichan@freebox.fr> wrote:
>> Architecture must select HAVE_SECCOMP_FILTER_JIT and implement
>> seccomp_jit_compile() and seccomp_jit_free() if they intend to support
>> jitted seccomp filters.
>>
>> struct seccomp_filter has been moved to <linux/seccomp.h> to make its
>> content available to the jit compilation code.
>>
>> In a way similar to the net BPF, the jit compilation code is expected
>> to updates struct seccomp_filter.bpf_func pointer to the generated
>> code.
>>
>> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I'd love to see this for x86 too. I suspect it'd be a small change
> after this series lands.

Agreed - and thanks for working through the necessary changes!

Acked-By: Will Drewry <wad@chromium.org>
(for the series)
