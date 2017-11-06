From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 6 Nov 2017 23:03:20 +0100
Subject: [PATCH] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <c773682c-6045-a476-e0c8-04347624c4e3@amlogic.com>
References: <20171106075212.14275-1-yixun.lan@amlogic.com>
 <889b8fd5-31e4-1371-6121-0f1aec6fa777@baylibre.com>
 <c773682c-6045-a476-e0c8-04347624c4e3@amlogic.com>
Message-ID: <CAFBinCD4XTcunKx+heiRzW+g1b_sDL7wV5oMqPsE3ESP6Cf4_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On Mon, Nov 6, 2017 at 10:31 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> Hi Neil:
>
>
> On 11/06/17 16:57, Neil Armstrong wrote:
>> On 06/11/2017 08:52, Yixun Lan wrote:
>>> According to the datasheet, in Meson-GXBB/GXL series,
>>> The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
>>> while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].
>>>
>>> Test passed at gxl_skt dev board.
>>>
>>> Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>
>>> ---
>>> I think this error was introduced by a copy & paste from meson8 code?
>>> and we didn't notice them due to the SANA clock is also enabled by
>>> DTS (so SAR_ADC works fine)?
>>> ---
>>>  drivers/clk/meson/gxbb.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>> index b2d1e8ed7152..92168348ffa6 100644
>>> --- a/drivers/clk/meson/gxbb.c
>>> +++ b/drivers/clk/meson/gxbb.c
>>> @@ -1139,7 +1139,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
>>>  static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
>>>  static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
>>>  static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
>>> -static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
>>> +static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
>>>  static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
>>>  static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
>>>  static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
>>> @@ -1190,7 +1190,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG2, 9);
>>>  static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
>>>  static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
>>>  static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
>>> -static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
>>> +static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
>>>  static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
>>>  static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
>>>  static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
>>>
>>
>> Hi Yixun,
>>
>> Can you precise how it affects the saradc driver ? from the DT and clk PoV ?
>>
> the saradc module doesn't require sana clock (it's irrelvevant), we will
> send a patchset v3 to address this.
is the SANA clock irrelevant for the SAR ADC on all SoCs (even
Meson8/Meson8b/Meson8m2) or just on the GX SoCs?
also, do you know what "SANA" stands for?


Regards
Martin
