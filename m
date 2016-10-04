From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 18:32:29 +0200
Subject: [PATCH 10/14] dt-bindings: sound: Add sun8i audio card
 documentation
In-Reply-To: <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004163229.GR5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 11:46:23AM +0200, Myl?ne Josserand wrote:
> Add the documentation for dt-binding of the audio card driver
> for sun8i SoC.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/sound/sun8i-audio.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-audio.txt b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
> new file mode 100644
> index 0000000..2403983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
> @@ -0,0 +1,17 @@
> +* Allwinner A23/A33 audio card
> +
> +This binding implements the A33 audio card.
> +
> +Required properties:
> +- compatible: must be "allwinner,sun8i-audio"
> +- allwinner,audio-codec: must have the phandle of the audio codec
> +  ("sun8i-a33-codec", for example).
> +- allwinner,i2s-controller: must have the phandle of the DAI
> +  ("allwinner,sun4i-a10-i2s", for example)

You should probably have a link to the PRCM too, instead of relying on
the name of the device in your card, which is quite fragile.

Also, I'm wondering, shouldn't all these nodes be part of a single
MFD? They share the same address space (even though it's split
nicely), the same clocks, and really are just one big device. Chen-Yu,
Mark, any opinion?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/998b2002/attachment.sig>
