From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Apr 2017 15:08:16 +0200
Subject: [PATCH 2/5] mtd: nand: gpmi: add i.MX 7 SoC support
In-Reply-To: <5cf26d2b020392c875464c7504a9fb5b@agner.ch>
References: <20170421010755.18025-1-stefan@agner.ch>
 <20170421010755.18025-3-stefan@agner.ch>
 <af3fe671-c5fb-d3cf-c891-e6b7c973baa1@gmail.com>
 <5cf26d2b020392c875464c7504a9fb5b@agner.ch>
Message-ID: <8377dadc-043f-5932-cb13-3367db38a6dd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 05:15 AM, Stefan Agner wrote:
> On 2017-04-20 19:03, Marek Vasut wrote:
>> On 04/21/2017 03:07 AM, Stefan Agner wrote:
>>> Add support for i.MX 7 SoC. The i.MX 7 has a slightly different
>>> clock architecture requiring only two clocks to be referenced.
>>> The IP is slightly different compared to i.MX 6SoloX, but currently
>>> none of this differences are in use so there is no detection needed
>>> and the driver can reuse IS_MX6SX.
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>> index c8bbf5da2ab8..4a45d37ddc80 100644
>>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>> @@ -127,6 +127,18 @@ static const struct gpmi_devdata gpmi_devdata_imx6sx = {
>>>  	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
>>>  };
>>>
>>> +static const char * const gpmi_clks_for_mx7d[] = {
>>> +	"gpmi_io", "gpmi_bch_apb",
>>> +};
>>> +
>>> +static const struct gpmi_devdata gpmi_devdata_imx7d = {
>>> +	.type = IS_MX6SX,
>>
>> Would it make sense to use IS_MX7 here already to prevent future surprises ?
>>
> 
> Yeah I was thinking we can do it once we have an actual reason to
> distinguish.

So what are the differences anyway ?

> But then, adding the type would only require 2-3 lines of change if I
> add it to the GPMI_IS_MX6 macro...

Then at least add a comment because using type = IMX6SX right under
gpmi_data_mx7d can trigger some head-scratching. And put my R-B on V2.

-- 
Best regards,
Marek Vasut
