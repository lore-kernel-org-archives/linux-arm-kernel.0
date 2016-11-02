From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 2 Nov 2016 14:54:51 +0100
Subject: [PATCH v2 1/2] net: stmmac: Add OXNAS Glue Driver
In-Reply-To: <CAGhQ9VyAaqUy06kb_Mxewo+BbJnxe=e6=x8pFsVSY0Z6C-h=cg@mail.gmail.com>
References: <20161031105345.16711-1-narmstrong@baylibre.com>
 <20161031105442.17228-1-narmstrong@baylibre.com>
 <CAGhQ9VyAaqUy06kb_Mxewo+BbJnxe=e6=x8pFsVSY0Z6C-h=cg@mail.gmail.com>
Message-ID: <dd54dc6a-85ba-b9b9-be52-36212405de66@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 12:12 PM, Joachim Eastwood wrote:
> Hi Neil,
> 
> On 31 October 2016 at 11:54, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Add Synopsys Designware MAC Glue layer for the Oxford Semiconductor OX820.
>>
>> Acked-by: Joachim Eastwood <manabian@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> +static int oxnas_dwmac_init(struct oxnas_dwmac *dwmac)
>> +{
>> +       unsigned int value;
>> +       int ret;
>> +
>> +       /* Reset HW here before changing the glue configuration */
>> +       ret = device_reset(dwmac->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_prepare_enable(dwmac->clk);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
>> +       if (ret < 0)
>> +               return ret;
> 
> If regmap reading fails here, the clock will be left on as probe fails.
> 

Indeed, thanks.

Neil

[...]
> 
> 
> regards,
> Joachim Eastwood
> 
