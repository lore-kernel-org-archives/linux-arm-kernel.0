From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 29 Sep 2014 15:19:28 -0400
Subject: [PATCH v3 6/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: Your message of "Fri, 26 Sep 2014 10:54:15 +0200."
 <1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
 <1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <15685.1412018368@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Sep 2014 10:54:15 +0200, Gabriel FERNANDEZ said:
> SSC is the technique of modulating the operating frequency of a signal
> slightly to spread its radiated emissions over a range of frequencies.
> This reduction in the maximum emission for a given frequency helps meet
> radiated emission requirements.
> These settings are applicable for PCIE with Internal clock.

> +		writeb_relaxed(0x69, miphy_phy->base + MIPHY_PLL_SBR_3);
> +		writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
> +		writeb_relaxed(0x3c, miphy_phy->base + MIPHY_PLL_SBR_2);
> +		writeb_relaxed(0x21, miphy_phy->base + MIPHY_PLL_SBR_4);
> +		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);
> +		writeb_relaxed(0x02, miphy_phy->base + MIPHY_PLL_SBR_1);
> +		writeb_relaxed(0x00, miphy_phy->base + MIPHY_PLL_SBR_1);

I'd feel a lot better about all these magic numbers (and the triple write
to SBR_1) if the Changelog or something referenced where they came from....
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/b7d5b790/attachment.sig>
