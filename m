From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 5 Feb 2015 14:49:54 -0800
Subject: [PATCH -tip/urgent 1/2] [BUGFIX]kprobes: set
 kprobes_all_disarmed earlier to enable re-optimization.
In-Reply-To: <20150123064224.30731.30127.stgit@localhost.localdomain>
References: <20150123064217.30731.49156.stgit@localhost.localdomain>
 <20150123064224.30731.30127.stgit@localhost.localdomain>
Message-ID: <20150205144954.d93eda6ba8be265e23037799@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015 15:42:24 +0900 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> From: Wang Nan <wangnan0@huawei.com>
> 
> In original code, the probed instruction doesn't get optimized after
> 
> echo 0 > /sys/kernel/debug/kprobes/enabled
> echo 1 > /sys/kernel/debug/kprobes/enabled
> 
> This is because original code checks kprobes_all_disarmed in
> optimize_kprobe(), but this flag is turned off after calling that
> function. Therefore, optimize_kprobe() will see
> kprobes_all_disarmed == true and doesn't do the optimization.
> 
> This patch simply turns off kprobes_all_disarmed earlier to enable
> optimization.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

You sent the patches, so this should have been "Signed-off-by:". 
Documentation/SubmittingPatches section 12 has the details.

I have made that change to my copy of these two patches.
