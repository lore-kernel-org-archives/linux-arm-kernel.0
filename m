From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Sep 2017 14:59:59 +0200
Subject: [PATCH 7/7] ARM: dts: sun8i: h3: Enable AP6212 BT on uart3 on
 Nanopi M1 Plus
In-Reply-To: <1504062070-13523-8-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
 <1504062070-13523-8-git-send-email-embed3d@gmail.com>
Message-ID: <20170901125959.6ae37ez34vb7mh6d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 05:01:10AM +0200, Philipp Rossak wrote:
> From: Philipp Rossak <embed3d@gmail.com>
> 
> The BT side of the AP6212 WiFi/BT combo module is connected to
> uart3.
> 
> Enable BT on this board by enabling uart3 with using additionally
> the cts and rts pins.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

I've queued this patch for 4.15, but...

> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> index 3054308..8c12419 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -49,6 +49,7 @@
>  	aliases {
>  		ethernet0 = &emac;
>  		ethernet1 = &ap6212;
> +		serial1 = &uart3;

You'll also need an alias for serial 0 here. Can you send a follow up
patch to do so?

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/015b10e9/attachment-0001.sig>
