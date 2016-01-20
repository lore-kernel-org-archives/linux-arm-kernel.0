From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 20 Jan 2016 14:17:25 -0800
Subject: [PATCH] net: i40e: avoid unused function warnings
In-Reply-To: <2806620.EpZqDlZTO3@wuerfel>
References: <2806620.EpZqDlZTO3@wuerfel>
Message-ID: <1453328245.2958.28.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 11:42 +0100, Arnd Bergmann wrote:
> The addition of the geneve tunnel offload code left a couple
> of functions unconditionally defined but empty whenever CONFIG_VXLAN
> and CONFIG_GENEVE are disabled. gcc warns about this:
> 
> i40e_main.c:7049:13: warning: 'i40e_sync_udp_filters_subtask' defined
> but not used [-Wunused-function]
> i40e_main.c:8516:13: warning: 'i40e_add_vxlan_port' defined but not
> used [-Wunused-function]
> i40e_main.c:8561:13: warning: 'i40e_del_vxlan_port' defined but not
> used [-Wunused-function]
> i40e_main.c:8596:13: warning: 'i40e_add_geneve_port' defined but not
> used [-Wunused-function]
> i40e_main.c:8643:13: warning: 'i40e_del_geneve_port' defined but not
> used [-Wunused-function]
> 
> This moves the #ifdef statements to the outside of the affected
> functions, which avoids the warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6a899024058d ("i40e: geneve tunnel offload support")
> ---
> This is a harmless regression against v4.4, found on ARM randconfig
> builds

Thanks Arnd, I already have a patch from Eric Dumazet and Alex Duyck to
resolve this issue.

Dave- I plan on pushing the fix later today to net.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/2a220f92/attachment-0001.sig>
