From: ast@plumgrid.com (Alexei Starovoitov)
Date: Wed, 3 Dec 2014 07:54:32 -0800
Subject: [PATCH] bpf: arm64: lift restriction on last instruction
In-Reply-To: <1417595881-32218-1-git-send-email-zlim.lnx@gmail.com>
References: <1417595881-32218-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <CAMEtUuwJHC2eyOh3pD=qDXw1YbfJqx1a7W0o65n5Ur_B_TvNOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 3, 2014 at 12:38 AM, Zi Shen Lim <zlim.lnx@gmail.com> wrote:
> Earlier implementation assumed last instruction is BPF_EXIT.
> Since this is no longer a restriction in eBPF, we remove this
> limitation.
>
> Per Alexei Starovoitov [1]:
>> classic BPF has a restriction that last insn is always BPF_RET.
>> eBPF doesn't have BPF_RET instruction and this restriction.
>> It has BPF_EXIT insn which can appear anywhere in the program
>> one or more times and it doesn't have to be last insn.
>
> [1] https://lkml.org/lkml/2014/11/27/2
>
> Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>

yours is cleaner than my own attempt to fix it.
Thanks!
Acked-by: Alexei Starovoitov <ast@plumgrid.com>
