From: scottwood@freescale.com (Scott Wood)
Date: Fri, 28 Jun 2013 17:15:46 -0500
Subject: [1/4] Device tree entry for Freescale TDM controller
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
Message-ID: <20130628221545.GA9357@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> +tdm at 16000 {
> +	compatible = "fsl,tdm1.0";
> +	reg = <0x16000 0x200 0x2c000 0x2000>;
> +	clock-frequency = <0>;
> +	tdm_tx_clk = <2048000>;
> +	interrupts = <62 8 0 0>;
> +	fsl,max-time-slots = <128>;
> +};

tdm_tx_clk isn't in the binding (and should be named fsl,tdm-tx-clk if it
is meant to be here at all).

-Scott
