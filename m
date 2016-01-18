From: davem@davemloft.net (David Miller)
Date: Sun, 17 Jan 2016 19:15:45 -0500 (EST)
Subject: [PATCH 2/2] arm64: bpf: add extra pass to handle faulty codegen
In-Reply-To: <1452756802-16511-2-git-send-email-zlim.lnx@gmail.com>
References: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
 <1452756802-16511-2-git-send-email-zlim.lnx@gmail.com>
Message-ID: <20160117.191545.670534349073994378.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Shen Lim <zlim.lnx@gmail.com>
Date: Wed, 13 Jan 2016 23:33:22 -0800

> Code generation functions in arch/arm64/kernel/insn.c previously
> BUG_ON invalid parameters. Following change of that behavior, now we
> need to handle the error case where AARCH64_BREAK_FAULT is returned.
> 
> Instead of error-handling on every emit() in JIT, we add a new
> validation pass at the end of JIT compilation. There's no point in
> running JITed code at run-time only to trap due to AARCH64_BREAK_FAULT.
> Instead, we drop this failed JIT compilation and allow the system to
> gracefully fallback on the BPF interpreter.
> 
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>

Applied.
