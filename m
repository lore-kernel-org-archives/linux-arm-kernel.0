From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Jul 2012 10:59:36 +0100
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
In-Reply-To: <1342766789-28148-2-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
Message-ID: <20120720095935.GQ4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 12:16:26PM +0530, AnilKumar Ch wrote:

> +		vio_reg: regulator at 1 {
> +			reg = <1>;
> +			regulator-compatible = "vio";
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};

Every regulator here has a rather large voltage range specified with no
consumers added.  Are you sure these voltage ranges make sense in your
design and you've not just cut'n'pasted the entire voltage range that
your regulator supports without reference to what your board can do?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/46545946/attachment.sig>
