From: rgb@redhat.com (Richard Guy Briggs)
Date: Fri, 28 Feb 2014 15:45:57 -0500
Subject: [PATCH v6 2/2] arm64: audit: Add audit hook in
 ptrace/syscall_trace
In-Reply-To: <20140228161558.GE29546@mudshark.cambridge.arm.com>
References: <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-3-git-send-email-takahiro.akashi@linaro.org>
 <20140228161558.GE29546@mudshark.cambridge.arm.com>
Message-ID: <20140228204557.GJ16640@madcap2.tricolour.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/28, Will Deacon wrote:
> On Fri, Feb 28, 2014 at 05:17:15AM +0000, AKASHI Takahiro wrote:
> > This patch adds auditing functions on entry to or exit from
> > every system call invocation.
> > 
> > Acked-by: Richard Guy Briggs <rgb@redhat.com>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/arm64/kernel/ptrace.c |   54 ++++++++++++++++++++++++++------------------
> >  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> I think you need to do something like I did for arch/arm/, where we have
> separate trace functions for entry/exit to make sure that we invoke the
> various helpers in the correct order (for example, you want to invoke all
> the debug stuff *first* on entry, but *last* on exit).

I'd have to agree.  I've just had my head deep in audit_syscall_entry()
and syscall_get_arch to clean them up.  Since current is only ever fed
to syscall_get_arch() and regs is never used by syscall_get_arch(), I'm
looking at dropping both from the syscall_get_arch() args list, but
leave syscall_get_arch() as you have it for now.

> Will

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
