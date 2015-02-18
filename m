From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Feb 2015 16:21:02 -0500
Subject: [PATCH v4 0/5] ARM: shmobile: sh73a0/kzm9g: Complete
 multiplatform support
In-Reply-To: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
References: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150218212101.GE12754@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 03:52:35PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series completes the migration from kzm9g-reference (legacy
> DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
> common clock framework).
> 
> It depends on Simon's branch simple-pm-bus-for-v3.21.
> 
>   - The first two patches fix Ethernet on kzm9g, by adding a Bus State
>     Controller node, and moving the Ethernet node to it, and thus depends
>     on Simon's branch simple-pm-bus-for-v3.21,
>   - The third patch removes all kzm9g-reference support, now the
>     sh73a0 generic multiplatform case has the same feature set
>     (better, it provides 16 MiB more RAM!),
>   - The fourth patch fixes CONFIG_CPU_IDLE=y by adding a node for the TWD,
>     which could not be done before, as the TWD driver doesn't support DT
>     without CCF,
>   - The fifth path is new, and removes the now unused function
>     sh73a0_add_standard_devices_dt().
>  
> Thanks for applying!

Thanks, done.

With this patchset applied I am able to use NFS root with multiplatform
using shmobile_defconfig.
