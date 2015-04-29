From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Apr 2015 22:32:00 +0200
Subject: [PATCH] ARM: sunxi: dts: split IR pins for A10 and A20
In-Reply-To: <1430244287-29309-1-git-send-email-codekipper@gmail.com>
References: <1430244287-29309-1-git-send-email-codekipper@gmail.com>
Message-ID: <20150429203200.GJ6062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 28, 2015 at 08:04:47PM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Currently none of the target boards nor the driver supports
> IR TX. However this pin is used in a few instances as a GPIO.
> Split the pin ctrl descriptions so that only the IR RX is
> configured to be used.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 18 ++++++++++++++++--
>  arch/arm/boot/dts/sun7i-a20.dtsi | 18 ++++++++++++++++--
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 1d7fd68..50df9b7 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -798,14 +798,28 @@
>  			};
>  
>  			ir0_pins_a: ir0 at 0 {

I would have changed the name of that node to ir0_rx_pins_a, just to
make it clear what you're actually muxing.

(of course, that would require fixing the users of these nodes, but
that's fine.)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150429/32c1c11b/attachment-0001.sig>
