From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 15:57:49 +0800
Subject: [PATCH 4/5] ARM: dts: add device tree source for imx6sl SoC
In-Reply-To: <5183589A.5090109@de.bosch.com>
References: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
 <1367552995-31777-5-git-send-email-shawn.guo@linaro.org>
 <5183589A.5090109@de.bosch.com>
Message-ID: <20130503075747.GB31873@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 08:26:34AM +0200, Dirk Behme wrote:
> On 03.05.2013 05:49, Shawn Guo wrote:
> >Add SoC level device tree source for imx6sl.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >---
> >  arch/arm/boot/dts/imx6sl.dtsi |  777 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 777 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6sl.dtsi
> >
> >diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> >new file mode 100644
> 
> Just as a proposal do discuss: What's about to move the existing
> imx6qdl.dtsi to a imx6.dtsi and include it in
> 
> imx6q.dtsi
> imx6dl.dtsi
> imx6sl.dtsi
> 
No.  Doing that would mean we need to do another around of shuffling of
all imx6 dts files with one more common level added.  And it brings even
more churn than last time when we add imx6dl support, since we have more
stuff to move around for getting 3 common levels.  Comparing
imx6qdl.dtsi and imx6sl.dtsi, you will find that the effort is not
really worthy, because there are already enough differences there.

> then?
> 
> >+       soc {
> >+               #address-cells = <1>;
> >+               #size-cells = <1>;
> >+               compatible = "simple-bus";
> >+               interrupt-parent = <&intc>;
> >+               ranges;
> >+
> >+               L2: l2-cache at 00a02000 {
> >+                       compatible = "arm,pl310-cache";
> >+                       reg = <0x00a02000 0x1000>;
> >+                       interrupts = <0 92 0x04>;
> >+                       cache-unified;
> >+                       cache-level = <2>;
> >+               };
> The arm,tag-latency and arm,data-latency we recently added for the
> other SoCs are missing here?

Right, I will add it.

Shawn
