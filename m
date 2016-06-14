From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 14 Jun 2016 06:43:39 +0200
Subject: [linux-sunxi] [PATCH v3 07/13] spi: sunxi: rename constants to
 match between sun4i and sun6i
In-Reply-To: <CAGRGNgWFKXd64-wYbG0dQez8hbzC1BPWFsBXBr7tCjVO_DBwGQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <c27d58f634daa4785e90c2716c8bb90399db3bf2.1465490774.git.hramrach@gmail.com>
 <CAGRGNgWFKXd64-wYbG0dQez8hbzC1BPWFsBXBr7tCjVO_DBwGQ@mail.gmail.com>
Message-ID: <CAOMqctSp6ghbbjL5RDU30L9LMcBp=mHgK_ymtka5ngGTRDVSug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 14 June 2016 at 01:31, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Michal,
>
> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach@gmail.com> wrote:
>> SUNXI_CTL_ -> SUNXI_TFR_CTL_
>> SUNXI_TFR_CTL_LMTF -> SUNXI_TFR_CTL_FBS
>
> I don't know these abbreviations, are they both referring to the same thing?
>
>> SUNXI_TFR_CTL_CS_ACTIVE_LOW -> SUNXI_TFR_CTL_SPOL
>
> It looks like you're making the constant name less descriptive here.
> Is the old version (CS_ACTIVE_LOW) incorrect?
>
>> and some SUNXI_???_CTL_ -> SUNXI_CTL_
>> for constants migrated to different registers between sun4i and sun6i
>>
>> No functional change.
>>
>>  #define SUNXI_INT_CTL_REG              0x0c
>> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
>> index a27bf8f..f26b52a 100644
>> --- a/drivers/spi/spi-sun6i.c
>> +++ b/drivers/spi/spi-sun6i.c
>> @@ -26,9 +26,9 @@
>>  #define SUNXI_FIFO_DEPTH               128
>>
>>  #define SUNXI_GBL_CTL_REG              0x04
>> -#define SUNXI_GBL_CTL_BUS_ENABLE       BIT(0)
>> -#define SUNXI_GBL_CTL_MASTER           BIT(1)
>> -#define SUNXI_GBL_CTL_TP               BIT(7)
>> +#define SUNXI_CTL_ENABLE               BIT(0)
>> +#define SUNXI_CTL_MASTER               BIT(1)
>> +#define SUNXI_CTL_TP                   BIT(7)
>
> If these are bit definitions for the GBL register, why throw that
> information away?

Those bits are on the TFR register in the earlier IP so it makes
perfect sense to me this way.

Thanks

Michal
