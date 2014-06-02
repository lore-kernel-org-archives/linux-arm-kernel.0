From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jun 2014 14:33:53 +0100
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
Message-ID: <20140602133352.GC933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 03:15:21PM +0200, Holger Schurig wrote:
> Transmit clocking and pinmux?  Do you mean ENET_TX_EN?  Yep, that's
> set. Somehow barebox can send, it's just Linux that doesn't want to do
> it. Note that ENET_TX_CLK is not muxed, as it is for MII, not for
> RMII.
> 
> In case I confuse what you meant, here are excerpts from my DTS:

It's probably ENET_REF_CLK that's the cause of the problem.

> pinctrl_fec: fecgrp {
>    fsl,pins = <
>       MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b030
>       MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b030
>       MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b030
>       MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b030
>       MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b030
>       MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b030
>       MX6QDL_PAD_ENET_MDIO__ENET_MDIO     0x0B850
>       MX6QDL_PAD_ENET_MDC__ENET_MDC       0x1b030
>       MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b030
>       MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0x1b030
>       >;
> };

On the Microsom, I need:

      MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0xc0000000

Does that work for you?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
