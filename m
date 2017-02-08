From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Wed, 8 Feb 2017 10:45:52 +0900
Subject: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <20170208104552.497ea03171826cfb9e63b557@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  8 Feb 2017 01:24:14 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> kprobe_exceptions_notify() is not used on some of the architectures such
> as arm[64] and powerpc anymore. Introduce a weak variant for such
> architectures.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for all patches in this series.

Thank you!

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 43460104f119..60a702a05684 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1705,6 +1705,12 @@ void unregister_kprobes(struct kprobe **kps, int num)
>  }
>  EXPORT_SYMBOL_GPL(unregister_kprobes);
>  
> +int __weak __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> +					      unsigned long val, void *data)
> +{
> +	return NOTIFY_DONE;
> +}
> +
>  static struct notifier_block kprobe_exceptions_nb = {
>  	.notifier_call = kprobe_exceptions_notify,
>  	.priority = 0x7fffffff /* we need to be notified first */
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
