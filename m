From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 18 Sep 2018 08:44:43 -0500
Subject: [PATCH] mtd: rawnand: atmel: Fix potential NULL pointer
 dereference
In-Reply-To: <20180918154025.55137b03@bbrezillon>
References: <20180918133317.GA17358@embeddedor.com>
 <20180918154025.55137b03@bbrezillon>
Message-ID: <8c4ca9db-70bb-b4cc-32c8-55e28b514ddd@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 9/18/18 8:40 AM, Boris Brezillon wrote:
> Hi Gustavo,
> 
> On Tue, 18 Sep 2018 08:33:17 -0500
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
>> There is a potential execution path in which function
>> of_find_compatible_node() returns NULL. In such a case,
>> we end up having a NULL pointer dereference when accessing
>> pointer *nfc_np* in function of_clk_get().
>>
>> So, we better don't take any chances and fix this by null
>> checking pointer *nfc_np* before calling of_clk_get().
>>
>> Addresses-Coverity-ID: 1473052 ("Dereference null return value")
> 
> Can you add a Fixes tag here?
> 

Yep.

>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> index a38633a..ffa0c6b6 100644
>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> @@ -2035,6 +2035,11 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
>>  	nfc_np = of_find_compatible_node(dev->of_node, NULL,
>>  					 "atmel,sama5d3-nfc");
>>  
> 
> Can you drop this blank line?
> 

OK. Sure thing.

I'll send v2 shortly.

Thanks for the feedback.
--
Gustavo
