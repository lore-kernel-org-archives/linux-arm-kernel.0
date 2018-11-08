From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Nov 2018 10:14:10 +0000
Subject: [PATCH 3/9] arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
In-Reply-To: <ddf4d390-c631-c5ef-03dc-a0579a21d484@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <ddf4d390-c631-c5ef-03dc-a0579a21d484@free.fr>
Message-ID: <20181108101410.ir3tws7wduxtdsay@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 09:15:29PM +0100, Marc Gonzalez wrote:
> Commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Again, please describe things in the commit message, e.g.

  CONFIG_NF_CONNTRACK_IPV4 and CONFIG_NF_CONNTRACK_IPV6 haven't existed since
  commit:

    a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")

  ... so we can remove them from the arm64 defconfig.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

For the rest of this series, please update the commit messages to describe why
the cited commit means it's safe to drop the option.

Thanks,
Mark.

> ---
>  arch/arm64/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8d6878c1e794..58741c07a6ef 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -156,14 +156,12 @@ CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>  CONFIG_NETFILTER_XT_TARGET_LOG=m
>  CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> -CONFIG_NF_CONNTRACK_IPV4=m
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP_NF_FILTER=m
>  CONFIG_IP_NF_TARGET_REJECT=m
>  CONFIG_IP_NF_NAT=m
>  CONFIG_IP_NF_TARGET_MASQUERADE=m
>  CONFIG_IP_NF_MANGLE=m
> -CONFIG_NF_CONNTRACK_IPV6=m
>  CONFIG_IP6_NF_IPTABLES=m
>  CONFIG_IP6_NF_FILTER=m
>  CONFIG_IP6_NF_TARGET_REJECT=m
> -- 
> 2.17.1
