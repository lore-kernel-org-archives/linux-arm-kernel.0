From: ast@plumgrid.com (Alexei Starovoitov)
Date: Fri, 26 Jun 2015 01:25:59 -0700
Subject: [RFC PATCH] arm64: bpf: fix endianness conversion bugs
In-Reply-To: <1435282755-12011-1-git-send-email-xi.wang@gmail.com>
References: <1435282755-12011-1-git-send-email-xi.wang@gmail.com>
Message-ID: <558D0C97.2070107@plumgrid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/15 6:39 PM, Xi Wang wrote:
> Upper bits should be zeroed in endianness conversion:
>
> - even when there's no need to change endianness (i.e., BPF_FROM_BE
>    on big endian or BPF_FROM_LE on little endian);
>
> - after rev16.
>
> This patch fixes such bugs by emitting extra instructions to clear
> upper bits.
>
> Cc: Zi Shen Lim<zlim.lnx@gmail.com>
> Cc: Alexei Starovoitov<ast@plumgrid.com>
> Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
> Signed-off-by: Xi Wang<xi.wang@gmail.com>

Acked-by: Alexei Starovoitov <ast@plumgrid.com>

> The current testsuite catches the 16-bit bugs.  I'll send a separate
> patch that extends test_bpf to catch the 32-bit ones.

looking forward to it. Thanks.
