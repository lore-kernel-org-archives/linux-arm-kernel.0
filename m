From: balbi@TI.COM (Felipe Balbi)
Date: Wed, 10 Apr 2013 11:59:05 +0300
Subject: [PATCH v3 6/9] rcar-phy: correct base address
In-Reply-To: <201304100236.50822.sergei.shtylyov@cogentembedded.com>
References: <201304100236.50822.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130410085905.GN7983@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 10, 2013 at 02:36:50AM +0400, Sergei Shtylyov wrote:
> The memory region that is used by the driver overlaps EHCI and OHCI  register
> regions for absolutely no reason now  -- fix it  by adding offset of 0x800 to
> the base address, changing the register #define's accordingly. This has extra
> positive effect that we now can use devm_ioremap_resource()...
> 
> Note that the driver and the SoC code have to be in one patch to keep the code
> bisectable...
> 
> The patch has been tested on the Marzen board.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Felipe Balbi <balbi@ti.com>

This will conflict with latest phy changes but it's only a rename issue.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/d20b0ddd/attachment-0001.sig>
