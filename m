From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:14:50 +0100
Subject: [PATCH v2 1/4] dt-bindings: mrvl,mmp-timer: add clock
In-Reply-To: <20180918205455.25464-2-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-2-lkundrak@v3.sk>
Message-ID: <20181103191449.GG31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-09-18 22:54:52, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it
> 
>  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> index 9a6e251462e7..b8f02c663521 100644
> --- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> @@ -5,9 +5,13 @@ Required properties:
>  - reg : Address and length of the register set of timer controller.
>  - interrupts : Should be the interrupt number.
>  
> +Optional properties:
> +- clocks : Should contain a single entry describing the clock input.
> +
>  Example:
>  	timer0: timer at d4014000 {
>  		compatible = "mrvl,mmp-timer";
>  		reg = <0xd4014000 0x100>;
>  		interrupts = <13>;
> +		clocks = <&coreclk 2>;
>  	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/3932b2a0/attachment.sig>
