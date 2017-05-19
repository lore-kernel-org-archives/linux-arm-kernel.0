From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 20:02:15 +0200
Subject: [RFC PATCH 01/11] dt-bindings: update the binding for Allwinner
 H3 TVE support
In-Reply-To: <20170517164354.16399-2-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-2-icenowy@aosc.io>
Message-ID: <20170519180215.7lc7duueu74pt4kz@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 12:43:44AM +0800, Icenowy Zheng wrote:
> -On SoCs other than the A33 and V3s, there is one more clock required:
> +For the following compatibles:
> +   * allwinner,sun5i-a13-tcon
> +   * allwinner,sun6i-a31-tcon
> +   * allwinner,sun6i-a31s-tcon
> +   * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-v3s-tcon
> +there is one more clock and one more property required:
> + - clocks:
> +   - 'tcon-ch0': The clock driving the TCON channel 0
> + - clock-output-names: Name of the pixel clock created
> +
> +For the following compatibles:
> +   * allwinner,sun5i-a13-tcon
> +   * allwinner,sun6i-a31-tcon
> +   * allwinner,sun6i-a31s-tcon
> +   * allwinner,sun8i-h3-tcon0
> +there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1

Putting ID's in the compatible name is usually a bad idea. What is the
difference between the two? Only that the second one doesn't have a
clock?

That seems highly unlikely. How does it generate the pixel clock
frequency?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/6b634b74/attachment.sig>
