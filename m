From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Apr 2012 07:42:47 +0800
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <4F82F386.7080303@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
 <20120409115549.GB18692@S2101-09.ap.freescale.net>
 <4F82E9A3.1030606@gmail.com>
 <20120409141347.GC18692@S2101-09.ap.freescale.net>
 <4F82F386.7080303@gmail.com>
Message-ID: <20120409234241.GE18692@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 09:34:46AM -0500, Rob Herring wrote:
> On 04/09/2012 09:13 AM, Shawn Guo wrote:
...
> >
> > 	uart_serial_clk: uart-baud {
> > 		compatible = "fsl,imx6q-clock";
> > 		#clock-cells = <0>;
> > 		/* clocks = <&ipg_per_clk>; */
> > 		clocks = <???>;
> 
> This is a provider node not a consumer, so you don't have a clocks
> property.

To me, any clock except root is not only a provider but also a consumer.
If "clocks" property is required for a consumer ...

> You could, but then you need the parent clock defined in the DT.
> 
..., then we need to define the entire clock tree in the DT.

> The compatible property here looks too generic. In the CCM code, how do
> you match it to the uart baud clock? You shouldn't be using the name.
> 
The code was copied from my early implementation which gets the entire
clock tree and every clock (reg, bits, shift) represented in DT, and I
do not need to map it to CCM code at all.

> You need to first decide if you are going to define each clock in the DT

That was my preference, but it brings too many clock nodes into DT.

> or just the whole CCM as a node.
> You can't really do something in the
> middle or be evolving it over time. You could perhaps make the PLLs be
> separate nodes and inputs to the CCM. As they really are separate h/w
> blocks.

I do not understand this part.

-- 
Regards,
Shawn
