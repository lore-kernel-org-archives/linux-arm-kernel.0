From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 14 Aug 2014 12:04:51 +0200
Subject: [PATCH v3 0/4] ARM: vf610: add FlexCAN support
In-Reply-To: <53C532B0.9020507@pengutronix.de>
References: <cover.1405428166.git.stefan@agner.ch>
 <53C532B0.9020507@pengutronix.de>
Message-ID: <53EC89C3.3070800@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 03:54 PM, Marc Kleine-Budde wrote:
> On 07/15/2014 02:56 PM, Stefan Agner wrote:
>> This series adds support for Vybrid (aka vf610) to the FlexCAN
>> controller and extends the device tree accordingly.
>>
>> Changes in v3:
>> - Return error number in flexcan_get_berr_counter if clock enabling fails
>> - Add the FLEXCANX_EN clocks as new clocks
>>
>> Changes in v2:
>> - Split out patch (seperate dt, clocks and driver changes)
>> - Use spaces for hardware feature flags table
>> - Remove drive-by change of esdhc register length
>> - Added related fix which enables clock in berr_counter
>>
>> Stefan Agner (4):
>>   ARM: dts: vf610: add FlexCAN node
>>   ARM: imx: clk-vf610: fix FlexCAN clock gating
>>   can: flexcan: switch on clocks before accessing ecr register
>>   can: flexcan: add vf610 support for FlexCAN
>>
>>  arch/arm/boot/dts/vf610.dtsi            | 23 +++++++++
>>  arch/arm/mach-imx/clk-vf610.c           |  6 ++-
>>  drivers/net/can/flexcan.c               | 91 +++++++++++++++++++++++++++++----
>>  include/dt-bindings/clock/vf610-clock.h |  4 +-
>>  4 files changed, 110 insertions(+), 14 deletions(-)
> 
> I'm taking patch 3+4 via the linux-can-next tree.

Applied to linux-can-next, with the modified version of the 3/4.

Thanks,
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
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140814/f104fc15/attachment.sig>
