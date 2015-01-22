From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Jan 2015 21:22:22 +0100
Subject: [PATCH] ARM: sunxi: dt: Fix aliases
In-Reply-To: <54BFB1FA.6090405@elopez.com.ar>
References: <1421838263-20332-1-git-send-email-maxime.ripard@free-electrons.com>
 <54BFB1FA.6090405@elopez.com.ar>
Message-ID: <20150122202222.GS4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Wed, Jan 21, 2015 at 11:04:42AM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> El 21/01/15 a las 08:04, Maxime Ripard escibi?:
> >Commit f77d55a3b56a ("serial: 8250_dw: get index of serial line from DT
> >aliases") made the serial driver now use the serial aliases to get the tty
> >number, pointing out that our aliases have been wrong all along.
> >
> >Remove them from the DTSI and add custom ones in the relevant boards.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  arch/arm/boot/dts/sun4i-a10.dtsi                 | 12 ------------
> >  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  6 ++++++
> >  arch/arm/boot/dts/sun5i-a10s.dtsi                |  8 --------
> >  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 ++++
> >  arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  4 ++++
> >  arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  4 ++++
> >  arch/arm/boot/dts/sun5i-a13.dtsi                 |  5 -----
> >  arch/arm/boot/dts/sun6i-a31.dtsi                 | 10 ----------
> >  arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  6 ++++++
> >  arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  8 ++++++++
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  3 +++
> >  arch/arm/boot/dts/sun7i-a20.dtsi                 | 12 ------------
> >  arch/arm/boot/dts/sun8i-a23.dtsi                 |  9 ---------
> >  arch/arm/boot/dts/sun9i-a80-optimus.dts          |  5 +++++
> >  arch/arm/boot/dts/sun9i-a80.dtsi                 | 10 ----------
> >  15 files changed, 40 insertions(+), 66 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> >index e3422309e54b..e20a5855bef8 100644
> >--- a/arch/arm/boot/dts/sun4i-a10.dtsi
> >+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> >@@ -15,18 +15,6 @@
> >  / {
> >  	interrupt-parent = <&intc>;
> >
> >-	aliases {
> >-		ethernet0 = &emac;
> 
> (...)
> 
> >diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> >index 3c3c1920788a..c67e39b4ccb9 100644
> >--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> >+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> >@@ -16,14 +16,6 @@
> >  / {
> >  	interrupt-parent = <&intc>;
> >
> >-	aliases {
> >-		ethernet0 = &emac;
> 
> (...)
> 
> >--- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >@@ -52,16 +52,6 @@
> >  / {
> >  	interrupt-parent = <&gic>;
> >
> >-	aliases {
> >-		serial0 = &uart0;
> >-		serial1 = &uart1;
> >-		serial2 = &uart2;
> >-		serial3 = &uart3;
> >-		serial4 = &uart4;
> >-		serial5 = &uart5;
> >-		ethernet0 = &gmac;
> 
> (...)
> 
> >diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >index e21ce5992d56..cab0eab179df 100644
> >--- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >@@ -52,18 +52,6 @@
> >  / {
> >  	interrupt-parent = <&gic>;
> >
> >-	aliases {
> >-		ethernet0 = &gmac;
> 
> (...)
> 
> It worries me that you're dropping the ethernet0 alias while adjusting this;
> I believe u-boot uses it to fill in the mac address on the DT[1]. This may
> cause dual IP address assignments to devices (one to u-boot and one to
> linux), broken connectivity (unexpected IP addr assigned to linux when eg.
> using static DHCP) or other such interesting stuff.

Ah, good point, I forgot about that. I'll re-add them in the v2.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/832f2a2b/attachment-0001.sig>
