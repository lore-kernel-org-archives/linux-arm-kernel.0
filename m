From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Apr 2015 21:35:38 +0200
Subject: [PATCH v8 2/4] ARM: sunxi: dt: Add DT bindings documentation for
 SUNXI Security System
In-Reply-To: <1429771523-2936-3-git-send-email-clabbe.montjoie@gmail.com>
References: <1429771523-2936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1429771523-2936-3-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150423193538.GF28007@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 08:45:21AM +0200, LABBE Corentin wrote:
> This patch adds documentation for Device-Tree bindings for the Security System cryptographic accelerator driver.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/crypto/sunxi-ss.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/sunxi-ss.txt b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> new file mode 100644
> index 0000000..a566803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> @@ -0,0 +1,9 @@
> +* Allwinner Security System found on A20 SoC
> +
> +Required properties:
> +- compatible : Should be "allwinner,sun7i-a20-crypto".
> +- reg: Should contain the Security System register location and length.
> +- interrupts: Should contain the IRQ line for the Security System.
> +- clocks : A phandle to the functional clock node of the Security System module

You actually need two clock references, not just a single phandle.

> +- clock-names : Name of the functional clock, should be "ahb" and "mod".

And we usually have an example after too.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150423/32b27854/attachment.sig>
