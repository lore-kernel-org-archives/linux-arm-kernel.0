From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 15:54:01 -0600
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the machine
 name
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BFB79.30801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> The fsl_ssi probe function detects the client machine name using model
> property of the device tree.  But it will not work for the ARM client
> machines which are to be added.  The model property is given as a
> descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> Instead, the compatible property gives the machine name.

If you apply this change to the P1022DS as well, then you can eliminate
the need to check for "P1022" and "P1022DS", since the compatible string
in the P1022DS DTS has always said, "fsl,P1022DS".

-- 
Timur Tabi
Linux kernel developer at Freescale
