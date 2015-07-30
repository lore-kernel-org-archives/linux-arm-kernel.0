From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 12:22:33 +0200
Subject: [PATCH v2 2/3] ARM: at91/dt: add basic dtsi for sama5d2 SoC
In-Reply-To: <20150729150218.GA6073@piout.net>
References: <1438079151-29653-1-git-send-email-nicolas.ferre@atmel.com>
 <1438079151-29653-3-git-send-email-nicolas.ferre@atmel.com>
 <20150729150218.GA6073@piout.net>
Message-ID: <55B9FAE9.3030906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/07/2015 17:02, Alexandre Belloni a ?crit :
> Hi,
> 
> On 28/07/2015 at 12:25:50 +0200, Nicolas Ferre wrote :
>> +
>> +		sdmmc0: sdio-host at a0000000 {
>> +			compatible = "atmel,sama5d2-sdhci";
>> +			reg = <0xa0000000 0x300>;
>> +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
>> +			clock-names = "hclock", "multclk", "baseclk";
> 
> Those bindings have not been taken yet. Are you confident enough this
> will go in as-is?

You're right: I'll remove these nodes as well as the ones about the
classD and generated clocks. That way we avoid anticipating on drivers
that are not-so-quite-merged-yet-but-probably-will ;-)

Bye,


>> +			status = "disabled";
>> +		};
>> +
> 


-- 
Nicolas Ferre
