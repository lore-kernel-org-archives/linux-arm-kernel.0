From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Jul 2015 10:55:53 +0800
Subject: [PATCH] ARM: dts: vf-colibri: define stdout-path property
In-Reply-To: <bed79bcac594f3efece6acb3c24ae543@agner.ch>
References: <1435910799-11706-1-git-send-email-stefan@agner.ch>
 <20150713151004.GA26642@tiger>
 <bed79bcac594f3efece6acb3c24ae543@agner.ch>
Message-ID: <20150717025553.GA12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 04:05:50PM +0200, Stefan Agner wrote:
> On 2015-07-13 17:10, Shawn Guo wrote:
> > On Fri, Jul 03, 2015 at 10:06:39AM +0200, Stefan Agner wrote:
> >> Define Vybrid's UART0, connected to the Colibri pinout UART_A, as
> >> standard output.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> >> index 2cbe663..cb199ae 100644
> >> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> >> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> >> @@ -10,6 +10,7 @@
> >>  / {
> >>  	chosen {
> >>  		bootargs = "console=ttyLP0,115200";
> >> +		stdout-path = "serial0:115200n8";
> > 
> > With this change, can bootargs just be dropped?
> 
> I guess it would break a (fairly old) kernel which does not support
> stdout-path yet?

The DT ABI requires that the new kernel doesn't break anything
with old DTB, but doesn't require the compatibility between new DTB
and old kernel.

Shawn
