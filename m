From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Jan 2015 20:22:52 +0100
Subject: [PATCH v2 1/5] rtc: armada38x: Add the device tree binding
 documentation
In-Reply-To: <1421257155-3379-2-git-send-email-gregory.clement@free-electrons.com>
References: <1421257155-3379-1-git-send-email-gregory.clement@free-electrons.com>
 <1421257155-3379-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150114202252.457d328e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 14 Jan 2015 18:39:11 +0100, Gregory CLEMENT wrote:

> +Required properties:
> +- compatible : Should be "marvell,armada-380-rtc"
> +- reg: physical base address of the controller and length of memory
> +  mapped region, associated to the reg-name "rtc". The other entry is
> +  related to the interrupt control from the SoC, associated to the
> +  reg-name "soc-interrupt".

soc-interrupt or...

> +- reg-names: names of the mapped memory regions listed in regs
> +    property in the same order: "rtc" and "soc-int".

soc-int ?

> +rtc at a3800 {
> +	compatible = "marvell,armada-380-rtc";
> +	reg = <0xa3800 0x20>, <0x184a0 0x0c>;

Any reason to use <0x184A0 0xC> instead of <0x184A8 0x4> ? According to
the datasheet, there is only this 184A8 register for RTC stuff.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
