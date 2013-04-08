From: timur@tabi.org (Timur Tabi)
Date: Sun, 07 Apr 2013 21:49:03 -0500
Subject: [PATCH v2 08/11] ASoC: fsl-ssi: imx ac97 support
In-Reply-To: <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
Message-ID: <5162301F.9090000@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> This patch copies some parts from imx-ssi to support AC97 on
> imx27-pca100 and imx27-pcm043. It is activated with a new fsl,imx-ac97
> bool property. It was tested on imx27-pca100.

I'm not crazy about this patch -- it seems a bit hackish.  There are too 
many "if (imx_ac97)" clauses.  Large pieces of code that don't appear to 
be related to AC97 are indented in an if-clause.  I especially don't like 
the "If we use AC97, the registers are already setup correctly".

-- 
Timur Tabi
