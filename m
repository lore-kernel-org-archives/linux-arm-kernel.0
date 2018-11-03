From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:15:05 +0100
Subject: [PATCH v2 2/4] DT: marvell,mmp2: add clock to the timer
In-Reply-To: <20180918205455.25464-3-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-3-lkundrak@v3.sk>
Message-ID: <20181103191505.GH31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-09-18 22:54:53, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/arm/boot/dts/mmp2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 766bbb8495b6..58e0098a007d 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -130,6 +130,7 @@
>  				compatible = "mrvl,mmp-timer";
>  				reg = <0xd4014000 0x100>;
>  				interrupts = <13>;
> +				clocks = <&soc_clocks MMP2_CLK_TIMER>;
>  			};
>  
>  			uart1: uart at d4030000 {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/a274387a/attachment.sig>
