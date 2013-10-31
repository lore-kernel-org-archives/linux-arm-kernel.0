From: timur@tabi.org (Timur Tabi)
Date: Thu, 31 Oct 2013 07:04:29 -0500
Subject: [PATCH v3 3/4] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
References: <cover.1383207153.git.b42378@freescale.com>
 <da997ce67d9817364248ca1eba716bb6c7814a24.1383207153.git.b42378@freescale.com>
Message-ID: <5272474D.5000207@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolin Chen wrote:
> +	if (ssi_private->use_dual_fifo) {
> +		write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
> +		write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
> +		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
> +	} else {
> +		write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
> +		write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
> +		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
> +	}

Why do you need the "else" part?  Why can't you just do this:

if (ssi_private->use_dual_fifo) {
	write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
	write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
}
