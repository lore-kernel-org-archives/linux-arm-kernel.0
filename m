From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 26 Nov 2018 16:13:24 +0100
Subject: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
In-Reply-To: <CAFBinCCjmw=8ESk0tztWszXnuA4aqWqC8_wdpvMtSYfwZ-KT=A@mail.gmail.com>
References: <20181121111922.1277-1-narmstrong@baylibre.com>
 <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com>
 <5e87ffda-4a38-f45b-00c4-6b73dc721656@baylibre.com>
 <CAFBinCCjmw=8ESk0tztWszXnuA4aqWqC8_wdpvMtSYfwZ-KT=A@mail.gmail.com>
Message-ID: <b5bdaca0-326e-ada8-507b-1eb494e7c3c0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 22/11/2018 23:05, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Thu, Nov 22, 2018 at 9:26 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Martin,
>>
>> On 21/11/2018 22:53, Martin Blumenstingl wrote:
>>> Hi Neil,
>>>
>>> On Wed, Nov 21, 2018 at 12:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> The GXL Documentation specifies 12 bits for the Fractional bit field,
>>>> bit the last bits have a different purpose that we cannot handle right
>>>> now, so update the bitwidth to have correct fractional calculations.
>>> I assume you have more accurate documentation than what's available publicly:
>>> - the S805 datasheet doesn't have any documentation for this register at all
>>> - the S905 datasheet states that HHI_HDMI_PLL_CNTL2[11:0] are DIV_FRAC
>>> - the S905X and S912 datasheets state that SDMNC_POWER is at
>>> HHI_HDMI_PLL_CNTL2[6:0], SDMNC_ULMS is at HHI_HDMI_PLL_CNTL2[9:7] and
>>> SSC_DEP_SEL is at HHI_HDMI_PLL_CNTL2[13:10]
>>> - the S905X and S912 datasheets state that HHI_HDMI_PLL_CNTL1[11:0] are DIV_FRAC
>>
>> On S905, the HHI_HDMI_PLL_CNTL2 is at address 0xc9 << 2, but on S905X/S905D/S912 the
>> equivalent register at same address is named HHI_HDMI_PLL_CNTL1.
>>
>> They changed the numbering of registers between these 2 SoCs, but the register
>> content and addresses are similar for m/n/frac/reset.
> I totally missed that - thanks for the explanation!
> 
>>>
>>> can you confirm that the public S905X and S912 documentation is wrong
>>> and that the .frac field is really part of HHI_HDMI_PLL_CNTL2 instead
>>> of HHI_HDMI_PLL_CNTL1?
>>
>> Is is part of HHI_HDMI_PLL_CNTL1 but at address of S905 HHI_HDMI_PLL_CNTL2.
>>
>> When jerome pushed the PLL support earlier, he added a comment.
>> I simply forgot to put it back when I added back the GXL HDMI PLL DCO.
> I'm curious: do you know whether the fractional divider field on
> Meson8b is 10 or 12 bits wide?
> 
> if you can add a short note about the naming confusion to the patch
> description when applying the patch:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I'll add back the comments about the register shift and i'll apply
it for a next PR.

Thanks,
Neil

> 
> 
> Regards
> Martin
> 
