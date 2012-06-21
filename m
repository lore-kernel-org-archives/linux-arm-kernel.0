From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 21 Jun 2012 01:56:23 -0700
Subject: [PATCH RESEND v4] input: keyboard: Add keys driver for the
 LPC32xx SoC
In-Reply-To: <1339443891-15197-1-git-send-email-stigge@antcom.de>
References: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Message-ID: <20120621085623.GF2193@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:44:51PM +0200, Roland Stigge wrote:
> This patch adds a driver for the key scan interface of the LPC32xx SoC
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> For the DT binding: Acked-by: Rob Herring <rob.herring@calxeda.con>

Not a real review, just a quick question - if th driver is DT-only now
do we need to have the platform data or it would make more sense to read
DT-bindings and fill the main device structure directly?

Thanks.

> +
> +	matrix_keypad_build_keymap(NULL, NULL, kscandat->kscancfg->matrix_sz,
> +				   kscandat->kscancfg->matrix_sz,
> +				   kscandat->kscancfg->keymap, kscandat->input);

This function may fail now.

-- 
Dmitry
