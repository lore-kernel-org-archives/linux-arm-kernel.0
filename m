From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Aug 2014 13:14:06 +0200
Subject: [PATCH 10/14] arm64: dts: add pinctrl support to EXYNOS7
In-Reply-To: <1409132660-1898-2-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <53FDBD7E.3050102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

Please see my comments inline.

On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
> Add the required pin configuration support to EXYNOS7

[snip]

> +/ {
> +	/* ALIVE block @10580000 */
> +	pinctrl at 10580000 {

This syntax repeating the whole hierarchy of nodes in every dts file is
considered obsolete in case of Exynos DT sources. Please switch to
reference-based one. Please see related files for Exynos5260 and 5800 as
examples.

[snip]

> +		disp_teson: disp_teson {
> +			samsung,pins = "gpg0-1";
> +			samsung,pin-function = <2>;
> +		};
> +
> +		disp_tesoff: disp_tesoff {
> +			samsung,pins = "gpg0-1";
> +			samsung,pin-function = <0>;

This is not a special function, so I don't think it belongs to this file.

Best regards,
Tomasz
