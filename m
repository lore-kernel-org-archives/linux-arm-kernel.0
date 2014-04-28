From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 28 Apr 2014 15:26:41 +0200
Subject: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20140428132641.GA9590@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:06:34PM +0100, Ben Dooks wrote:
> With the addition of clock-indices, we need to change the renesas
> clock implementation to use these instead of the local definition
> of "renesas,clock-indices".
> 
> Since this will break booting with older device trees, we add a
> simple auto-detection of which properties are present.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt        | 2 +-
>  drivers/clk/shmobile/clk-mstp.c                                  | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 5992dce..02a25d9 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt

What about mentioning the old binding as deprecated in this file...

>  
> +	if (of_find_property(np, "clock-indices", &i))
> +		idxname = "clock-indices";
> +	else
> +		idxname = "renesas,clock-indices";

...and here in the code? It might also be a tad more intuitive to check
for the depracted binding, and if not found, use the new one as default,
i.e. switch the logic of the if block. Very minor nit, though.

But in general,

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/cc9f5c3c/attachment.sig>
