From: michael@amarulasolutions.com (Michael Nazzareno Trimarchi)
Date: Sat, 2 Jun 2018 16:04:13 +0200
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
In-Reply-To: <CAOMZO5BVhjwGpJ22qBihKcjWyvBkzNPU0cNtNY9HToLLEkYByA@mail.gmail.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
 <CAOMZO5BVhjwGpJ22qBihKcjWyvBkzNPU0cNtNY9HToLLEkYByA@mail.gmail.com>
Message-ID: <CAOf5uwneWyjNpD-tGGL7CgL2_jJFvDtzbi+NBg7wqGMGR4qGCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, Jun 2, 2018 at 3:48 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Stefan,
>
> On Tue, May 22, 2018 at 9:25 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>>> --- a/include/dt-bindings/clock/imx6ul-clock.h
>>> +++ b/include/dt-bindings/clock/imx6ul-clock.h
>>> @@ -242,20 +242,25 @@
>>>  #define IMX6UL_CLK_CKO2_PODF         229
>>>  #define IMX6UL_CLK_CKO2                      230
>>>  #define IMX6UL_CLK_CKO                       231
>>> +#define IMX6UL_CLK_GPIO1             232
>>> +#define IMX6UL_CLK_GPIO2             233
>>> +#define IMX6UL_CLK_GPIO3             234
>>> +#define IMX6UL_CLK_GPIO4             235
>>> +#define IMX6UL_CLK_GPIO5             236
>>
>> this change looks like a breakage of devicetree ABI. You are changing the mean of the existing clock IDs on i.MX6ULL, which probably regress the combination of older DTBs with newer kernel.
>
> Good point! I will send a fix for f5a4670de96678 ("clk: imx: Add new
> clo01 and clo2 controlled
> by CCOSR") which did the same reordering.
>

ull is a preatty new platform so one board was listed. Are you sure
that we need?

Michael

> Thanks



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
