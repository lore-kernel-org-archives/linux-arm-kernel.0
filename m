From: peda@axentia.se (Peter Rosin)
Date: Thu, 29 Mar 2018 15:37:43 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180329153322.5e2fc1e7@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
Message-ID: <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-29 15:33, Boris Brezillon wrote:
> On Thu, 29 Mar 2018 15:10:54 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>> flash accesses have a tendency to cause display disturbances. Add a
>> module param to disable DMA from the NAND controller, since that fixes
>> the display problem for me.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> index b2f00b398490..2ff7a77c7b8e 100644
>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> @@ -129,6 +129,11 @@
>>  #define DEFAULT_TIMEOUT_MS			1000
>>  #define MIN_DMA_LEN				128
>>  
>> +static bool atmel_nand_avoid_dma __read_mostly;
>> +
>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
> 
> I'm not a big fan of those driver specific cmdline parameters. Can't we
> instead give an higher priority to HLCDC master using the bus matrix?

I don't know if it will be enough, but we sure can try. However, I have
no idea how to do that. I will happily test stuff though...

Cheers,
Peter
