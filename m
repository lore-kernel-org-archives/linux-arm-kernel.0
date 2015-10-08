From: nikolay@cumulusnetworks.com (Nikolay Aleksandrov)
Date: Thu, 8 Oct 2015 14:51:05 +0200
Subject: [PATCH v2] bridge/netfilter: avoid unused label warning
In-Reply-To: <5180534.sSnu9AX8xS@wuerfel>
References: <5180534.sSnu9AX8xS@wuerfel>
Message-ID: <561666B9.8070802@cumulusnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2015 02:30 PM, Arnd Bergmann wrote:
> With the ARM mini2440_defconfig, the bridge netfilter code gets
> built with both CONFIG_NF_DEFRAG_IPV4 and CONFIG_NF_DEFRAG_IPV6
> disabled, which leads to a harmless gcc warning:
> 
> net/bridge/br_netfilter_hooks.c: In function 'br_nf_dev_queue_xmit':
> net/bridge/br_netfilter_hooks.c:792:2: warning: label 'drop' defined but not used [-Wunused-label]
> 
> This gets rid of the warning by cleaning up the code to avoid
> the respective #ifdefs causing this problem, and replacing them
> with if(IS_ENABLED()) checks. I have verified that the resulting
> object code is unchanged, and an additional advantage is that
> we now get compile coverage of the unused functions in more
> configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: dd302b59bde0 ("netfilter: bridge: don't leak skb in error paths")
> ---
> Version 2:
> 
> Rebased to git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
> 

Looks good to me,

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
