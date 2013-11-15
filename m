From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Nov 2013 10:01:19 +0100
Subject: [PATCH] ARM: nommu: Include asm/procinfo.h to fix build warning
In-Reply-To: <1384486680.11140.1.camel@phoenix>
References: <1384486680.11140.1.camel@phoenix>
Message-ID: <20131115090118.GA26458@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 11:38:00AM +0800, Axel Lin wrote:
> Include asm/procinfo.h to fix below build warning:
>   CC      arch/arm/mm/nommu.o
> arch/arm/mm/nommu.c:303:17: warning: 'struct proc_info_list' declared inside parameter list [enabled by default]
> arch/arm/mm/nommu.c:303:17: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  arch/arm/mm/nommu.c | 1 +
>  1 file changed, 1 insertion(+)

Interesting, I didn't see those at the time when writing the patch.
Perhaps some reordering of includes subsequently caused this to happen?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131115/cf0b6c13/attachment-0001.sig>
