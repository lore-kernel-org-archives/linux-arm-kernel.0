From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jan 2015 10:08:25 +0100
Subject: [PATCH v2 12/13] ARM: dts: sun6i: Add sun6i-a31s.dtsi
In-Reply-To: <549820A4.9090900@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-13-git-send-email-hdegoede@redhat.com>
 <20141219183450.GZ4820@lukather> <54954E77.4070302@redhat.com>
 <20141221223941.GC4820@lukather> <549820A4.9090900@redhat.com>
Message-ID: <20150105090825.GA31311@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 22, 2014 at 02:46:12PM +0100, Hans de Goede wrote:
> On 21-12-14 23:39, Maxime Ripard wrote:
> >On Sat, Dec 20, 2014 at 11:24:55AM +0100, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 19-12-14 19:34, Maxime Ripard wrote:
> >>>On Wed, Dec 17, 2014 at 06:18:23PM +0100, Hans de Goede wrote:
> >>>>Add a dtsi file for A31s based boards.
> >>>>
> >>>>Since the  A31s is the same die as the A31 in a different package, this dtsi
> >>>>simply includes sun6i-a31.dtsi and then overrides the pinctrl compatible to
> >>>>reflect the different package, everything else is identical.
> >>>>
> >>>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>---
> >>>>Changes in v2:
> >>>>-include sun6i-a31.dtsi and override the pinctrl compatible, rather then
> >>>>  copying everything
> >>>>---
> >>>>  arch/arm/boot/dts/sun6i-a31s.dtsi | 62 +++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 62 insertions(+)
> >>>>  create mode 100644 arch/arm/boot/dts/sun6i-a31s.dtsi
> >>>>
> >>>>diff --git a/arch/arm/boot/dts/sun6i-a31s.dtsi b/arch/arm/boot/dts/sun6i-a31s.dtsi
> >>>>new file mode 100644
> >>>>index 0000000..d0bd2b9
> >>>>--- /dev/null
> >>>>+++ b/arch/arm/boot/dts/sun6i-a31s.dtsi
> >>>>@@ -0,0 +1,62 @@
> >>>>+/*
> >>>>+ * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
> >>>>+ *
> >>>>+ * This file is dual-licensed: you can use it either under the terms
> >>>>+ * of the GPL or the X11 license, at your option. Note that this dual
> >>>>+ * licensing only applies to this file, and not this project as a
> >>>>+ * whole.
> >>>>+ *
> >>>>+ *  a) This library is free software; you can redistribute it and/or
> >>>>+ *     modify it under the terms of the GNU General Public License as
> >>>>+ *     published by the Free Software Foundation; either version 2 of the
> >>>>+ *     License, or (at your option) any later version.
> >>>>+ *
> >>>>+ *     This library is distributed in the hope that it will be useful,
> >>>>+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>>+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>>+ *     GNU General Public License for more details.
> >>>>+ *
> >>>>+ *     You should have received a copy of the GNU General Public
> >>>>+ *     License along with this library; if not, write to the Free
> >>>>+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> >>>>+ *     MA 02110-1301 USA
> >>>>+ *
> >>>>+ * Or, alternatively,
> >>>>+ *
> >>>>+ *  b) Permission is hereby granted, free of charge, to any person
> >>>>+ *     obtaining a copy of this software and associated documentation
> >>>>+ *     files (the "Software"), to deal in the Software without
> >>>>+ *     restriction, including without limitation the rights to use,
> >>>>+ *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>>>+ *     sell copies of the Software, and to permit persons to whom the
> >>>>+ *     Software is furnished to do so, subject to the following
> >>>>+ *     conditions:
> >>>>+ *
> >>>>+ *     The above copyright notice and this permission notice shall be
> >>>>+ *     included in all copies or substantial portions of the Software.
> >>>>+ *
> >>>>+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >>>>+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >>>>+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>>>+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>>>+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>>>+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>>>+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>>>+ *     OTHER DEALINGS IN THE SOFTWARE.
> >>>>+ */
> >>>>+
> >>>>+/*
> >>>>+ * The A31s is the same die as the A31 in a different package, this is
> >>>>+ * reflected by it having different pinctrl compatible everything else is
> >>>>+ * identical.
> >>>>+ */
> >>>>+
> >>>>+/include/ "sun6i-a31.dtsi"
> >>>>+
> >>>>+/ {
> >>>>+	soc at 01c00000 {
> >>>>+		pio: pinctrl at 01c20800 {
> >>>>+			compatible = "allwinner,sun6i-a31s-pinctrl";
> >>>>+		};
> >>>>+	};
> >>>>+};
> >>>
> >>>Given your previous changes, you should also update the enable-method.
> >>
> >>I've not added a new compatible for the enable-method, given that
> >>this is the exact same die, so the 2 are 100?% compatible, just like you
> >>insisted that "allwinner,sun4i-a10-mod0-clk" should be used for the ir-clk
> >>since it was 100% compatible to that I believe that the enable method
> >>should use the existing compatible and not invent a new one for something
> >>which is 100% compatible.
> >
> >Yeah, you have a point and I agree, but your patch 3 does add a
> >CPU_METHOD_OF_DECLARE for the A31s.
> 
> Ah right, it does, my bad.
> 
> >Since I was going to push the branch now that 3.19-rc1 is out, do you
> >want me to edit your patch before doing so?
> 
> Yes, please drop the addition of the extra CPU_METHOD_OF_DECLARE, or let
> me know if you want a new version instead.

I just modified it, and pushed it, no need to resend it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/d7540c0b/attachment.sig>
