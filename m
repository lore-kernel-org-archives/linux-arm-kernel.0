From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 19 Oct 2018 13:50:07 +0800
Subject: [PATCH v2] clk: sunxi-ng: enable so-said LDOs for A64 SoC's
 pll-mipi clock
In-Reply-To: <153988319489.5275.13596491306786109572@swboyd.mtv.corp.google.com>
References: <20181018070729.52943-1-icenowy@aosc.io>
 <153988319489.5275.13596491306786109572@swboyd.mtv.corp.google.com>
Message-ID: <AF7A4F82-D6B1-4F86-ACF1-2786E990C0B6@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?10?19? GMT+08:00 ??1:19:54, Stephen Boyd <sboyd@kernel.org> ??:
>Quoting Icenowy Zheng (2018-10-18 00:07:29)
>> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
>> register is called "LDO{1,2}_EN", and according to the BSP source
>code
>> from Allwinner , the LDOs are enabled during the clock's enabling
>> process.
>> 
>> The clock failed to generate output if the two LDOs are not enabled.
>> 
>> Add the two bits to the clock's gate bits, so that the LDOs are
>enabled
>> when the PLL is enabled.
>> 
>> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>
>Looks OK to me from not knowing anything about this driver. Shall I
>pick
>directly into clk-next for next release?

I prefer to wait for an ACK from Maxime.

>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
