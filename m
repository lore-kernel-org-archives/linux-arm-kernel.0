From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 26 Sep 2015 19:29:37 +0200
Subject: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
In-Reply-To: <1443212447-5841-3-git-send-email-marek@goldelico.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
 <1443212447-5841-3-git-send-email-marek@goldelico.com>
Message-ID: <20150926172936.GD22315@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Sep 25, 2015 at 10:20:47PM +0200, Marek Belisko wrote:
> Added new iio properties which are required for twl4030-charger driver and
> allow to use twl4030-madc indirectly.
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 36ae916..482b7aa 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,6 +22,8 @@
>  	charger: bci {
>  		compatible = "ti,twl4030-bci";
>  		interrupts = <9>, <2>;
> +		io-channels = <&twl4030_madc 11>;
> +		io-channel-name = "vac";
>  		bci3v1-supply = <&vusb3v1>;
>  	};

Acked-By: Sebastian Reichel <sre@kernel.org>

This patch is missing correct To/Cc:

$ grep -A5 "OMAP DEVICE TREE SUPPORT" MAINTAINERS
OMAP DEVICE TREE SUPPORT
M:	Beno?t Cousson <bcousson@baylibre.com>
M:	Tony Lindgren <tony@atomide.com>
L:	linux-omap at vger.kernel.org
L:	devicetree at vger.kernel.org
S:	Maintained

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150926/9343b2ec/attachment.sig>
