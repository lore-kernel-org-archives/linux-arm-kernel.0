From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 19 Mar 2014 11:07:13 +0000
Subject: [PATCH v2 1/7] sched: remove unused SCHED_INIT_NODE
In-Reply-To: <1395165409-18055-2-git-send-email-vincent.guittot@linaro.org>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53297A61.4010605@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/14 17:56, Vincent Guittot wrote:
> not used since new numa scheduler init sequence
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Applied to metag tree for v3.15,

Thanks for spotting it.

Cheers
James

> ---
>  arch/metag/include/asm/topology.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/arch/metag/include/asm/topology.h b/arch/metag/include/asm/topology.h
> index 8e9c0b3..e95f874 100644
> --- a/arch/metag/include/asm/topology.h
> +++ b/arch/metag/include/asm/topology.h
> @@ -3,33 +3,6 @@
>  
>  #ifdef CONFIG_NUMA
>  
> -/* sched_domains SD_NODE_INIT for Meta machines */
> -#define SD_NODE_INIT (struct sched_domain) {		\
> -	.parent			= NULL,			\
> -	.child			= NULL,			\
> -	.groups			= NULL,			\
> -	.min_interval		= 8,			\
> -	.max_interval		= 32,			\
> -	.busy_factor		= 32,			\
> -	.imbalance_pct		= 125,			\
> -	.cache_nice_tries	= 2,			\
> -	.busy_idx		= 3,			\
> -	.idle_idx		= 2,			\
> -	.newidle_idx		= 0,			\
> -	.wake_idx		= 0,			\
> -	.forkexec_idx		= 0,			\
> -	.flags			= SD_LOAD_BALANCE	\
> -				| SD_BALANCE_FORK	\
> -				| SD_BALANCE_EXEC	\
> -				| SD_BALANCE_NEWIDLE	\
> -				| SD_SERIALIZE,		\
> -	.last_balance		= jiffies,		\
> -	.balance_interval	= 1,			\
> -	.nr_balance_failed	= 0,			\
> -	.max_newidle_lb_cost	= 0,			\
> -	.next_decay_max_lb_cost	= jiffies,		\
> -}
> -
>  #define cpu_to_node(cpu)	((void)(cpu), 0)
>  #define parent_node(node)	((void)(node), 0)
>  
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/cc4d03e2/attachment.sig>
