From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Aug 2016 21:36:00 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160823064451.25997-3-icenowy@aosc.xyz>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
 <20160823064451.25997-3-icenowy@aosc.xyz>
Message-ID: <20160824193600.GS8103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 23, 2016 at 02:44:51PM +0800, Icenowy Zheng wrote:
> UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
> on iNet D978 Rev2 board.
> 
> Enable the UART1 to make it possible to use the modified hciattach by
> Realtek to drive the BT part of RTL8723BS.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I guess you could fold that patch into the previous one.

> ---
>  arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> index 78823d8..3ac22d4 100644
> --- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> +++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> @@ -48,6 +48,10 @@
>  	model = "INet-D978 Rev 02";
>  	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
>  
> +	aliases {
> +		serial1 = &uart1;
> +	};
> +

Is there any other UART in the system?

The alias is not supposed to be about the controller index, but the
index in the board, meaning that if you only have a single UART, that
would be serial0.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/74587d12/attachment-0001.sig>
