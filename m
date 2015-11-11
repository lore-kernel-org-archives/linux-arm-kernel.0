From: davem@davemloft.net (David Miller)
Date: Wed, 11 Nov 2015 12:35:48 -0500 (EST)
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111172659.GA86334@ast-mbp.thefacebook.com>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
Message-ID: <20151111.123548.1039494689070388545.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Nov 2015 09:27:00 -0800

> BPF_XADD == atomic_add() in kernel. period.
> we are not going to deprecate it or introduce something else.

Agreed, it makes no sense to try and tie C99 or whatever atomic
semantics to something that is already clearly defined to have
exactly kernel atomic_add() semantics.
