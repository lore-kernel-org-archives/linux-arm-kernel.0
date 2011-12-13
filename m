From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 13 Dec 2011 08:54:11 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212144445.GA10437@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
 <4EE6047D.9080209@gmail.com>
 <20111212134949.GD16835@b20223-02.ap.freescale.net>
 <20111212144445.GA10437@S2100-06.ap.freescale.net>
Message-ID: <20111213005410.GB28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:44:47PM +0800, Shawn Guo wrote:
> On Mon, Dec 12, 2011 at 09:49:54PM +0800, Richard Zhao wrote:
> > On Mon, Dec 12, 2011 at 07:41:17AM -0600, Rob Herring wrote:
> > > On 12/11/2011 11:40 PM, Shawn Guo wrote:
> > > > On Mon, Dec 12, 2011 at 11:42:26AM +0800, Richard Zhao wrote:
> > > >> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > >> ---
> > > >>  arch/arm/boot/dts/imx6q-sabrelite.dts |   54 +++++++++++++++++++++++++++++++++
> > > >>  arch/arm/mach-imx/mach-imx6q.c        |    1 +
> > > >>  2 files changed, 55 insertions(+), 0 deletions(-)
> > > >>  create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts
> > > >>
> > > >> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > >> new file mode 100644
> > > >> index 0000000..d54363f
> > > >> --- /dev/null
> > > >> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > > >> @@ -0,0 +1,54 @@
> > > >> +/*
> > > >> + * Copyright 2011 Freescale Semiconductor, Inc.
> > > >> + * Copyright 2011 Linaro Ltd.
> > > >> + *
> > > >> + * The code contained herein is licensed under the GNU General Public
> > > >> + * License. You may obtain a copy of the GNU General Public License
> > > >> + * Version 2 or later at the following locations:
> > > >> + *
> > > >> + * http://www.opensource.org/licenses/gpl-license.html
> > > >> + * http://www.gnu.org/copyleft/gpl.html
> > > >> + */
> > > >> +
> > > >> +/dts-v1/;
> > > >> +/include/ "imx6q.dtsi"
> > > >> +
> > > >> +/ {
> > > >> +	model = "Freescale i.MX6 Quad SABRE Lite Board";
> > > >> +	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> > > >> +
> > > >> +	chosen {
> > > >> +		bootargs = "console=ttymxc1,115200";
> > > >> +	};
> > > >> +
> > > > Maybe we can start dropping this, since kernel is now able to get
> > > > bootargs from atags even in case that bootloader can not pass dtb
> > > > and the dtb is appended to kernel image.
> > > > 
> > > >> +	memory {
> > > >> +		reg = <0x10000000 0x40000000>;
> > > >> +	};
> > > >> +
> > > >> +	soc {
> > > >> +		aips-bus at 02100000 { /* AIPS2 */
> > > >> +			enet at 02188000 {
> > > >> +				phy-mode = "rgmii";
> > > >> +				local-mac-address = [01 04 9F 01 1B 61];
> > > > 
> > > > Do we still have no way to figure the mac address from hardware setup
> > > > (fuse or something) on sabrelite board?
> > > > 
> > > >> +				phy-reset-gpios = <&gpio2 23 0>; /* gpio3 23 */
> > > > 
> > > > Nit: If you want to comment it, please comment it in the consistent way,
> > > > which is '/* GPIO3_23 */'.
> > > 
> > > Better yet, why don't you name the phandles starting at 1 so the comment
> > > isn't needed at all.
> > Good idea, but it needs another patch, because it effects all imx6 boards.
> > Shawn, what do you think?
> > 
> When I was firstly working out the dts for imx51, I followed what most
> dts files do, numbering phandle and label name from 0, while imx
> reference manual happens to indexing hardware block from 1.  This
> mismatch have been existing in kernel for long time, since kernel is
> numbering platform device from 0 too.
> 
> I'm not really sure if there is a convention on this.  But since Rob
> (as device tree maintainer) says it can be numbered from 1, I'm fine
> to accept a patch fixing this up for all imx dts files.
I'll prepare the patch.

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
