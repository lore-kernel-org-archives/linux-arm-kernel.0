From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Jun 2013 21:55:12 +0200
Subject: [PATCH V3 3/4] ARM: dts: tegra: Correct PCIe entry
In-Reply-To: <1370372252-4332-3-git-send-email-jagarwal@nvidia.com>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <1370372252-4332-3-git-send-email-jagarwal@nvidia.com>
Message-ID: <20130610195511.GC25859@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 12:27:31AM +0530, Jay Agarwal wrote:
[...]
> @@ -29,7 +29,7 @@
>  		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port 0 configuration space */
>  			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
>  			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
> -			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
> +			  0x81000000 0 0          0x02000000 0 0x00100000   /* downstream I/O */
>  			  0x82000000 0 0x20000000 0x20000000 0 0x10000000   /* non-prefetchable memory */
>  			  0xc2000000 0 0x30000000 0x30000000 0 0x10000000>; /* prefetchable memory */

That increases the I/O region size from 64 KiB to 1 MiB. Why is that
necessary? I/O operations can only address 64 KiB, so I don't think
adding more makes any sense.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/3878be8d/attachment.sig>
