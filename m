From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 14 Jul 2014 10:09:54 +0200
Subject: [PATCH v2 0/4] ARM: vf610: add FlexCAN support
In-Reply-To: <cover.1405322992.git.stefan@agner.ch>
References: <cover.1405322992.git.stefan@agner.ch>
Message-ID: <53C39052.7040400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 09:48 AM, Stefan Agner wrote:
> This series adds support for Vybrid (aka vf610) to the FlexCAN
> controller and extends the device tree accordingly.
> 
> Changes in v2:
> - Split out patch (seperate dt, clocks and driver changes)
> - Use spaces for hardware feature flags table
> - Remove drive-by change of esdhc register length
> - Added related fix which enables clock in berr_counter
> 
> Stefan Agner (4):
>   ARM: dts: vf610: add FlexCAN node
>   ARM: imx: clk-vf610: fix FlexCAN clock gating
>   can: flexcan: switch on clocks before accessing ecr register
>   can: flexcan: add vf610 support for FlexCAN
> 
>  arch/arm/boot/dts/vf610.dtsi  | 23 +++++++++++
>  arch/arm/mach-imx/clk-vf610.c |  6 ++-
>  drivers/net/can/flexcan.c     | 89 ++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 106 insertions(+), 12 deletions(-)

Shawn, what's the best way to upstream this? With your Ack, I can take
everything via linux-can-next.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/d458cb36/attachment.sig>
