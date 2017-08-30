From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Aug 2017 16:48:43 +0200
Subject: [RESEND PATCH 2/2] arm64: allwinner: pine64: Enable spi0/spi1
In-Reply-To: <20170829202652.5476-3-stefan.bruens@rwth-aachen.de>
References: <20170829202652.5476-1-stefan.bruens@rwth-aachen.de>
 <20170829202652.5476-3-stefan.bruens@rwth-aachen.de>
Message-ID: <20170830144843.zyqmf3awivzfqtbf@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Aug 29, 2017 at 10:26:52PM +0200, Stefan Br?ns wrote:
> The two spi channels/controllers are available on the PI-2 resp. Euler
> connector, enable both. Contrary to the Pi, the A64 SOC only supports
> one chip select, so the second chipselect is not available (though
> it can be emulated using gpio chipselect).
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 827168bc22ed..f25274e8b3e0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -124,6 +124,14 @@
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +};

Anything on the Euler or PI connector is muxable to some other
function. We cannot enforce a default, since we can't know for sure
that all our users will use it that way (even though the majority
probably will). This is why you also have those nodes populated but
disabled for the uart for example in the pine64 DTS.

But in our case, there's not much to populate :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/f28dca51/attachment.sig>
