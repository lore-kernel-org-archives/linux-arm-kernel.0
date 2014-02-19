From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 13:44:58 +0900
Subject: [PATCH v2 5/5] ARM: dts: add bcm590xx pmu support and enable for
 bcm28155-ap
In-Reply-To: <1392765432-9111-6-git-send-email-mporter@linaro.org>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-6-git-send-email-mporter@linaro.org>
Message-ID: <20140219044458.GA2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:17:12PM -0500, Matt Porter wrote:

> +			csr_reg: regulator at 13 {
> +				reg = <13>;
> +				regulator-compatible = "csr";
> +				regulator-min-microvolt = <860000>;
> +				regulator-max-microvolt = <1440000>;
> +			};

You should not be setting voltage ranges like this in a .dtsi - you've
no idea if these voltage ranges are in fact valid for any given board so
they can't be set safely.  In general I would not expect to see any
configuration at all for regulators in an include file for the chip.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/0491f4d5/attachment.sig>
