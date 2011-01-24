From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 24 Jan 2011 14:36:44 -0800
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <1295468747-22796-3-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
Message-ID: <1295908604.29639.62.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
> +       int global_offset = 0;
> +
> +       if (cpu_is_msm7x01()) {
> +               msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE;
> +               msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x10;
> +       } else if (cpu_is_msm7x30()) {
> +               msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE + 0x04;
> +               msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x24;
> +       } else if (cpu_is_qsd8x50()) {
> +               msm_clocks[MSM_CLOCK_GPT].regbase = MSM_CSR_BASE;
> +               msm_clocks[MSM_CLOCK_DGT].regbase = MSM_CSR_BASE + 0x10;
> +       } else if (cpu_is_msm8x60()) {
> +               msm_clocks[MSM_CLOCK_GPT].regbase = MSM_TMR_BASE + 0x04;
> +               msm_clocks[MSM_CLOCK_DGT].regbase = MSM_TMR_BASE + 0x24;
> +
> +               /* Use CPU0's timer as the global timer. */
> +               global_offset = MSM_TMR0_BASE - MSM_TMR_BASE;
> +       } else
> +               BUG(); 

Ifdef's here would be OK I think, your already using the "runtime"
checks ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
