From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 04 Feb 2013 16:00:20 +0400
Subject: [PATCH 2/2] ARM: davinci: da850: add wdt OF_DEV_AUXDATA entry
In-Reply-To: <510FA09F.7030604@ti.com>
References: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
 <1359016695-10362-3-git-send-email-anilkumar.v@ti.com>
 <510FA09F.7030604@ti.com>
Message-ID: <510FA2D4.7090807@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-02-2013 15:50, Sekhar Nori wrote:

> Auxdata is not evm specific. This can instead be called da850_auxdata_lookup[].

> Also, I dont think it is necessary to add auxdata in a separate patch
> from dt nodes. So, I fixed these issues and came up with below patch. I
> tested basic wdt reboot. reboot command is still broken (with or
> without this patch). Can you please look at that?

> Thanks,
> Sekhar

> ----8<----
> From: "Kumar, Anil" <anilkumar.v@ti.com>
> Date: Thu, 24 Jan 2013 14:08:14 +0530
> Subject: [PATCH 1/1] ARM: davinci: da850: add wdt DT node

> Add da850 wdt DT node.

> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[...]

> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 8dd15c0..2800090 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -88,6 +88,11 @@
>   				      19>;
>   			status = "disabled";
>   		};
> +		wdt: wdt at 1c21000 {
> +			compatible = "ti,davinci-wdt";
> +			reg = <0x21000 0xfff>;

    Not 0x1000? This is region size, not upper limit.

WBR, Sergei
