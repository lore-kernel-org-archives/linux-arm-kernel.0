From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 8 Jul 2016 09:31:56 +0200
Subject: [PATCH v2 1/6] dt-bindings: clock: add DT binding for the Xtal
 clock on Armada 3700
In-Reply-To: <1467931071-31004-2-git-send-email-gregory.clement@free-electrons.com>
References: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
 <1467931071-31004-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160708093156.4f235b85@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri,  8 Jul 2016 00:37:46 +0200, Gregory CLEMENT wrote:

> +gpio1: gpio at 13800 {
> +	compatible = "marvell,mvebu-gpio-3700",	"syscon", "simple-mfd";

I find this compatible string not very consistent with what we do for
other drivers, it should have been:

	marvell,armada-3700-gpio

or something like that.


> +	xtalclk: xtal-clk {
> +		compatible = "marvell,armada-3700-xtal-clock";

See here for example.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
