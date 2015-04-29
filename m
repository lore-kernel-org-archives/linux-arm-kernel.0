From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Wed, 29 Apr 2015 09:46:14 -0700
Subject: [PATCH 0/4] Seccomp filter JIT support on ARM.
In-Reply-To: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150429164607.GA12410@Alexeis-MBP.westell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 03:37:33PM +0200, Nicolas Schichan wrote:
> Greetings,
> 
> The following patches allow the use of the existing JIT code under
> arch/arm for seccomp filters.
> 
> The first patch makes bpf_migrate_filter() available so that seccomp
> code can use it.
> 
> The second patch invokes the classic BPF JIT code and if this fails
> reverts to the internal BPF. The open coded double call to
> bpf_convert_filter() and bpf_prog_select_runtime() is replaced by
> bpf_migrate_filter()
> 
> The third patch adds support for loads from the seccomp_data structure in
> the ARM BPF JIT code.

the patches 1,2,3 look fine.

> The fourth and final patch fixes a bug in the emit_udiv() function
> when used to convert a BPF_ALU | BPF_DIV | BPF_K instruction in the
> ARM BPF JIT code.

this one looks independent from first three and probably should
be sent to stable?

Your cc list is different for every patch, why? What tree are you
thinking to go through? 1st patch is trivial, but 2nd belongs in
seccomp, 3rd and 4th are in arm32... I'd would say arm tree if Kees
is ok with it.
