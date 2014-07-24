From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 18:47:15 +0100
Subject: [PATCH] arm64: fix soft lockup due to large tlb flush range
In-Reply-To: <1406213775-28617-1-git-send-email-msalter@redhat.com>
References: <20140724142417.GE13371@arm.com>
 <1406213775-28617-1-git-send-email-msalter@redhat.com>
Message-ID: <20140724174714.GN13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 03:56:15PM +0100, Mark Salter wrote:
> Under certain loads, this soft lockup has been observed:
> 
>    BUG: soft lockup - CPU#2 stuck for 22s! [ip6tables:1016]
>    Modules linked in: ip6t_rpfilter ip6t_REJECT cfg80211 rfkill xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw vfat fat efivarfs xfs libcrc32c

Merged (with minor tweaks, comment added). Thanks.

-- 
Catalin
