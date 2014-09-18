From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 18 Sep 2014 13:48:57 +0930
Subject: [PATCH] aarch64: filter $x from kallsyms
In-Reply-To: <20140916213718.GR22012@redacted.bos.redhat.com>
References: <20140916213718.GR22012@redacted.bos.redhat.com>
Message-ID: <87r3z9o91q.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyle McMartin <kyle@redhat.com> writes:
> Similar to ARM, AArch64 is generating $x and $d syms... which isn't
> terribly helpful when looking at %pF output and the like. Filter those
> out in kallsyms, modpost and when looking at module symbols.
>
> Seems simplest since none of these check EM_ARM anyway, to just add it
> to the strchr used, rather than trying to make things overly
> complicated.
>
> initcall_debug improves:
> dmesg_before.txt: initcall $x+0x0/0x154 [sg] returned 0 after 26331 usecs
> dmesg_after.txt: initcall init_sg+0x0/0x154 [sg] returned 0 after 15461 usecs
>
> Signed-off-by: Kyle McMartin <kyle@redhat.com>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.
