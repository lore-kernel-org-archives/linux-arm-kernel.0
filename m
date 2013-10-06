From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Sun, 06 Oct 2013 09:56:32 -0700
Subject: [PATCH v4 net-next] fix unsafe set_memory_rw from softirq
In-Reply-To: <1380870846-3357-1-git-send-email-ast@plumgrid.com>
References: <1380870846-3357-1-git-send-email-ast@plumgrid.com>
Message-ID: <1381078592.12191.0.camel@edumazet-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-04 at 00:14 -0700, Alexei Starovoitov wrote:
> on x86 system with net.core.bpf_jit_enable = 1

> cannot reuse jited filter memory, since it's readonly,
> so use original bpf insns memory to hold work_struct
> 
> defer kfree of sk_filter until jit completed freeing
> 
> tested on x86_64 and i386
> 
> Signed-off-by: Alexei Starovoitov <ast@plumgrid.com>

Acked-by: Eric Dumazet <edumazet@google.com>
