From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 15:19:57 +0530
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <20180726065331.6186-4-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
Message-ID: <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
<o.rempel@pengutronix.de> wrote:

> Each MU has four pairs of rx/tx data register with four rx/tx interrupts
> which can also be used as a separate channel.
>
So the hardware actually supports 4 channels.

> -- #mbox-cells:  Must be 0. Number of cells in a mailbox
> +- #mbox-cells:  Must be:
> +               0 - for single channel mode. i.MX8* SCU protocol specific.
> +               1 - for multichannel (generic) mode.
> +
No, please.
DT bindings should reflect the real hardware, and not the software
mode we want the driver to work in.
Please define mbox-cells=1  and have the i.MX8* platform always ask
for channel-0.
