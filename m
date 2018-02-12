From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 12 Feb 2018 21:58:58 +0100
Subject: [PATCH v5 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
In-Reply-To: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180212205857.54nmli2jnv4fxrwm@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:44:21PM +0000, Fabrizio Castro wrote:
> Due to commits:
> * "ARM: shmobile: Add watchdog support",
> * "ARM: shmobile: rcar-gen2: Add watchdog support", and
> * "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
> we now have everything we needed for the watchdog to work on Gen2 and
> RZ/G1.
> 
> This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
> Gen2 and RZ/G1, and since on those platforms the rwdt clock needs to be
> always ON, when suspending to RAM we need to explicitly disable the
> counting by clearing TME from RWTCSRA.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> v4->v5:
> * various improvements suggested by Wolfram
> 

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/961780c2/attachment.sig>
