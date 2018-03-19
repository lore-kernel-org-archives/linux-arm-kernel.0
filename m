From: stefan.bruens@rwth-aachen.de (Stefan =?ISO-8859-1?Q?Br=FCns?=)
Date: Mon, 19 Mar 2018 01:04:29 +0100
Subject: [linux-sunxi] [PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers
In-Reply-To: <20180318232847.14278-5-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
 <20180318232847.14278-5-andre.przywara@arm.com>
Message-ID: <8200788.OcfDqQcPbJ@pebbles>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 19. M?rz 2018 00:28:47 CET Andre Przywara wrote:
> The Allwinner A64 SoC features two PWM controllers, which are fully
> compatible to the one used in the A13 and H3 chips.
> Add the respective device nodes (one for the "normal" PWM, the other for
> the one in the CPUS domain) and the pin their output is connected to.

"Add the nodes for the devices (...) and the pins their outputs are connected 
to."

> On the A64 the "normal" PWM is muxed together with one of the MDIO pins
> used to communicate with the Ethernet PHY, so it won't be usable on many
> boards. But the Pinebook laptop uses this pin for controlling the LCD
> backlight.
> The CPUS PWM pin however is routed to the "RPi2" header, at the same
> location as the PWM pin on the RaspberryPi.

The last sentence is misssing a reference to the Pine64.
 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28
> +++++++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> d783d164b9c3..fda1783b1c86 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -321,6 +321,11 @@
<...>

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/7d0a1f9e/attachment-0001.sig>
