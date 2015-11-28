From: rostedt@goodmis.org (Steven Rostedt)
Date: Sat, 28 Nov 2015 10:58:19 -0500
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <20151128105819.3451ab3e@grimm.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Nov 2015 15:50:09 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> On arm64, kstop_machine which is hugely disruptive to a running
> system is not needed to convert nops to ftrace calls or back,
> because that modifed code is a single 32bit instructions which
> is impossible to cross cache (or page) boundaries, and the used str
> instruction is single-copy atomic.

Is this really true? I thought that arm (and then perhaps arm64) has
some 2 byte instructions. If that's the case it is very well possible
that a 4 byte instruction can cross cache lines.

-- Steve

> 
> Cc: <stable@vger.kernel.org> # 3.18+
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> ---
>  arch/arm64/kernel/ftrace.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
