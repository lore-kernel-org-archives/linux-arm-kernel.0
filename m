From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 1 Feb 2016 23:01:44 +0000
Subject: [PATCH 06/11] clk: sunxi: add generic multi-parent bus clock
 gates driver
In-Reply-To: <20160201194000.282a253b14a2ab35df8b8cc7@free.fr>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-7-git-send-email-andre.przywara@arm.com>
 <20160201194000.282a253b14a2ab35df8b8cc7@free.fr>
Message-ID: <56AFE3D8.1000701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 18:40, Jean-Francois Moine wrote:
> On Mon,  1 Feb 2016 17:39:25 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> The Allwinner H3 SoC introduced bus clock gates with potentially
>> different parents per clock gate. The H3 driver chose to hardcode the
>> actual parent clock relation in the code.
>> Add a new driver (which has the potential to drive the H3 and also
>> the simple clock gates as well) which uses the power of DT to describe
>> this relationship in an elegant and flexible way.
>> Using one subnode for every parent clock we get away with a single
>> DT compatible match, which can be used as a fallback value in the
>> actual DTs without the need to add specific compatible strings to the
>> code.  This avoids adding a new driver or function for every new SoC.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog RFC .. v1:
>> - fix IRQ muxes to cover the three banks of the SoC
>> - amend naming of PCM pins

Just got embarrassed with seeing that this changelog here actually
belongs into the previous patch :$

>>
>>  drivers/clk/sunxi/Makefile          |   1 +
>>  drivers/clk/sunxi/clk-multi-gates.c | 105 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>  create mode 100644 drivers/clk/sunxi/clk-multi-gates.c
> 	[snip]
> 
> Glad to see that things are moving to the right way. Thanks.

> Acked-by: Jean-Francois Moine <moinejf@free.fr>

Thanks! I am relived to hear that (and hope that others agree as well
;-) If people are Ok with that approach I can do patches to move all
existing clock gates into one driver, but I guess this would be part of
a later series.

Cheers,
Andre.
