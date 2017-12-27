From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Dec 2017 12:14:07 +0800
Subject: [PATCH] ARM: dts: ls1021a: fix incorrect clock references
In-Reply-To: <20171221214432.3658852-1-arnd@arndb.de>
References: <20171221214432.3658852-1-arnd@arndb.de>
Message-ID: <20171227041405.GA5286@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 10:44:20PM +0100, Arnd Bergmann wrote:
> dtc warns about two 'clocks' properties that have an extraneous '1'
> at the end:
> 
> arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a
> arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2180000/mux at 77/i2c at 4/sgtl5000 at 2a:clocks[1])
> Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2190000/sgtl5000 at a
> arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2190000/sgtl5000 at a:clocks[1])
> 
> The clocks that get referenced here are fixed-rate, so they do not
> take any argument, and dtc interprets the next cell as a phandle, which
> is invalid.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

Thanks for the patch.  But I have queued up a couple of patches from
Fabio [1] for that.

Shawn

[1] https://www.spinics.net/lists/arm-kernel/msg624303.html
