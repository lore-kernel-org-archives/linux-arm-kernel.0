From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 14 Jul 2014 16:06:06 +0200
Subject: [PATCH v2 0/4] ARM: vf610: add FlexCAN support
In-Reply-To: <20140714140404.GJ2197@dragon>
References: <cover.1405322992.git.stefan@agner.ch>
 <53C39052.7040400@pengutronix.de> <20140714140404.GJ2197@dragon>
Message-ID: <53C3E3CE.10609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 04:04 PM, Shawn Guo wrote:
> On Mon, Jul 14, 2014 at 10:09:54AM +0200, Marc Kleine-Budde wrote:
>> On 07/14/2014 09:48 AM, Stefan Agner wrote:
>>> This series adds support for Vybrid (aka vf610) to the FlexCAN
>>> controller and extends the device tree accordingly.
>>>
>>> Changes in v2:
>>> - Split out patch (seperate dt, clocks and driver changes)
>>> - Use spaces for hardware feature flags table
>>> - Remove drive-by change of esdhc register length
>>> - Added related fix which enables clock in berr_counter
>>>
>>> Stefan Agner (4):
>>>   ARM: dts: vf610: add FlexCAN node
>>>   ARM: imx: clk-vf610: fix FlexCAN clock gating
>>>   can: flexcan: switch on clocks before accessing ecr register
>>>   can: flexcan: add vf610 support for FlexCAN
>>>
>>>  arch/arm/boot/dts/vf610.dtsi  | 23 +++++++++++
>>>  arch/arm/mach-imx/clk-vf610.c |  6 ++-
>>>  drivers/net/can/flexcan.c     | 89 ++++++++++++++++++++++++++++++++++++++-----
>>>  3 files changed, 106 insertions(+), 12 deletions(-)
>>
>> Shawn, what's the best way to upstream this? With your Ack, I can take
>> everything via linux-can-next.
> 
> Since this is a new support and there is nothing to maintain git bisect,
> I think the best way is to have the first two patches to go via my tree.

Fine, with me.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/1a244771/attachment.sig>
