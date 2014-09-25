From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Sep 2014 11:14:17 +0100
Subject: [PATCH] aarch64: filter $x from kallsyms
In-Reply-To: <87r3z9o91q.fsf@rustcorp.com.au>
References: <20140916213718.GR22012@redacted.bos.redhat.com>
 <87r3z9o91q.fsf@rustcorp.com.au>
Message-ID: <20140925101417.GG10390@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 05:18:57AM +0100, Rusty Russell wrote:
> Kyle McMartin <kyle@redhat.com> writes:
> > Similar to ARM, AArch64 is generating $x and $d syms... which isn't
> > terribly helpful when looking at %pF output and the like. Filter those
> > out in kallsyms, modpost and when looking at module symbols.
> >
> > Seems simplest since none of these check EM_ARM anyway, to just add it
> > to the strchr used, rather than trying to make things overly
> > complicated.
> >
> > initcall_debug improves:
> > dmesg_before.txt: initcall $x+0x0/0x154 [sg] returned 0 after 26331 usecs
> > dmesg_after.txt: initcall init_sg+0x0/0x154 [sg] returned 0 after 15461 usecs
> >
> > Signed-off-by: Kyle McMartin <kyle@redhat.com>
> 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks. Shall I understand that you are ok for me to take it via the
arm64 tree (or you'd prefer to merge it via your tree)?

-- 
Catalin
