From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Mon, 23 Nov 2015 11:23:02 +0100
Subject: [PATCH] netfilter: avoid harmless unnitialized variable warnings
In-Reply-To: <5585663.OcpAQiytKY@wuerfel>
References: <5585663.OcpAQiytKY@wuerfel>
Message-ID: <20151123102302.GA1614@salvia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 01:49:59PM +0100, Arnd Bergmann wrote:
> Several ARM default configurations give us warnings on recent
> compilers about potentially uninitialized variables in the
> nfnetlink code in two functions:
> 
> net/netfilter/nfnetlink_queue.c: In function 'nfqnl_build_packet_message':
> net/netfilter/nfnetlink_queue.c:519:19: warning: 'nfnl_ct' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
> 
> Moving the rcu_dereference(nfnl_ct_hook) call outside of the
> conditional code avoids the warning without forcing us to
> preinitialize the variable.

Applied, thanks Arnd.
