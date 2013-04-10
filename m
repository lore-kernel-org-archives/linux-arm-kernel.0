From: balbi@ti.com (Felipe Balbi)
Date: Wed, 10 Apr 2013 11:27:48 +0300
Subject: [PATCH v3 4/9] rcar-phy: remove EHCI internal buffer setup
In-Reply-To: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
References: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130410082748.GJ7983@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 10, 2013 at 02:32:30AM +0400, Sergei Shtylyov wrote:
> Now that the EHCI internal  buffer setup is done by the platform code, we  can
> remove  such code from this driver as it  never  really belonged here.  We also
> no longer need the 2nd memory region now (2nd EHCI controller is simply missing
> in e.g. R8A7778 SoC).
> 
> The patch has been tested on the Marzen and BOCK-W boards.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> Changes since version 2:
> - added a note about testing to the changelog;
> - added ACKs from Simon Horman and Kuninori Morimoto.
> 
> Changes since the original posting:
> - split R8A7779 SoC file change to a separate patch.
> 
>  drivers/usb/phy/rcar-phy.c |   28 ++++------------------------

you do realise this won't apply, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/9bdea30f/attachment.sig>
