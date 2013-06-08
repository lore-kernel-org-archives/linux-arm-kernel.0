From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 8 Jun 2013 10:11:07 -0300
Subject: [PATCH] serial: imx: enable the clocks for console
In-Reply-To: <1370678667-3514-1-git-send-email-b32955@freescale.com>
References: <20130608062307.GB22416@S2101-09.ap.freescale.net>
 <1370678667-3514-1-git-send-email-b32955@freescale.com>
Message-ID: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

On Sat, Jun 8, 2013 at 5:04 AM, Huang Shijie <b32955@freescale.com> wrote:

> +       if (!uart_console(port)) {
> +               retval = clk_prepare_enable(sport->clk_per);
> +               if (retval)
> +                       goto error_out1;
> +               retval = clk_prepare_enable(sport->clk_ipg);
> +               if (retval)
> +                       goto error_out1;

Here you should not jump to "error_out1".

You should jump to a different label and disable the sport->clk_per clock.

This was also wrong in your previous patch.
