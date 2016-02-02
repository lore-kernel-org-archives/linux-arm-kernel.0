From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Feb 2016 12:17:34 +0000
Subject: [PATCH 07/11] ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
In-Reply-To: <1454408864-24112-8-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-8-git-send-email-wens@csie.org>
Message-ID: <20160202121733.GO4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:27:40PM +0800, Chen-Yu Tsai wrote:

> +		reg_dcdc1: dcdc1 {
> +			regulator-name = "dcdc1";
> +		};

Why is this generic DTS include specifying regulator names?

> +		reg_rtc_ldo: rtc_ldo {
> +			/* RTC_LDO is a fixed, always-on regulator */
> +			regulator-always-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;

If the regulator itself is limited in this way there is no need to
specify this in the DTS.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/f280ae6e/attachment.sig>
