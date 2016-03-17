From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 10:19:19 -0700
Subject: [PATCH 3/8] clk: bcm2835: add missing osc and per clocks
In-Reply-To: <1456760642-2412-4-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
 <1456760642-2412-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <87twk5ja3s.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add definitions for the following clocks:
> * AVE0
> * DFT
> * GP0
> * GP1
> * GP2
> * PULSE
> * SLIM
> * SMI
> * TEC
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---

> +	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
> +		.name = "dft",
> +		.ctl_reg = CM_DFTCTL,
> +		.div_reg = CM_DFTDIV,
> +		.int_bits = 5,
> +		.frac_bits = 0),
> +	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
> +		.name = "dpi",
> +		.ctl_reg = CM_DPICTL,
> +		.div_reg = CM_DPIDIV,
> +		.int_bits = 4,
> +		.frac_bits = 8),

Oh, I see you've also doubled up the DFT definition here, when it seems
you meant to define DPI.  I've added a DPI enum value to fix it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/4d092fd4/attachment.sig>
