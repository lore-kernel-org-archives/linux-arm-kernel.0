From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 May 2017 15:35:17 -0300
Subject: [PATCH] PCI: imx6: fix downstream bus scanning
In-Reply-To: <20170510175752.6519-1-l.stach@pengutronix.de>
References: <20170510175752.6519-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5BYXx9VmhGrTv44O-njGQsz=GSRp9fA_VbkWapkqY+p=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Wed, May 10, 2017 at 2:57 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The change in Linux 4.12 to make PCI configuartion requests non-posted
> means that we are now getting a synchronous abort when the CFG space
> read to probe for downstream devices times out.
>
> Synchronous aborts need to be handled differently from the async aborts
> we were getting before, in particular the PC needs to be advanced when
> resolving the abort. This is mostly a copy of what other PCI drivers do
> on ARM to handle those aborts.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> This is a fix that needs to go in for 4.12, but I would hope to get
> some thorough testing before.

This fixes the kernel crash on my mx6q board with a PCI switch, thanks!

PCI Wifi card is also correctly detected.
