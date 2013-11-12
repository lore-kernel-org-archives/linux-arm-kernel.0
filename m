From: timur@tabi.org (Timur Tabi)
Date: Tue, 12 Nov 2013 06:55:05 -0600
Subject: [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
Message-ID: <52822529.5090502@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
>
> To ensure the first edge happens after enabling the TX side of the SSI unit and
> to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> demand only. To be sure, this patch does the same for the CCSR_SSI_SIER_RDMAE
> (RX side) bit.

This patch impacts PowerPC as well.  Have you tested it on that platform?
