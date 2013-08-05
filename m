From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 5 Aug 2013 11:56:14 -0700
Subject: [PATCH 6/6] mtd: ofpart: add compatible check for child nodes
In-Reply-To: <51FF8D90.2060308@atmel.com>
References: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
 <1375701279-11495-7-git-send-email-josh.wu@atmel.com>
 <51FF8D90.2060308@atmel.com>
Message-ID: <CAN8TOE_QBpGNQsdxXNPEHN7L_xhQHJE30px3PeE-vFxJOVyaRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems Artem applied this to l2-mtd.git. One comment below.

On Mon, Aug 5, 2013 at 4:33 AM, Josh Wu <josh.wu@atmel.com> wrote:
> Add device tree mail list to CC.
>
>
> On 8/5/2013 7:14 PM, Josh Wu wrote:
>>
>> In case that the nand device will support some features like Nand Flash
>> Controller, we want to make the sub feature as a sub node of nand device.
>>
>> Use such organization it is easy to enable/disable feature, also it is
>> back
>> compatible and more readable.
>>
>> If the sub-node has a compatible property then it is a driver not
>> partition.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Acked-by: Brian Norris <computersforpeace@gmail.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> ---
>> v3 --> v4:
>>    - remove the 'len' parameter, just use NULL.
>>    - refine the commit message.
>>    - also add a NOTE in devicetree/bindings/mtd/partition.txt.
>>
>>   .../devicetree/bindings/mtd/partition.txt          |    1 +
>>   drivers/mtd/ofpart.c                               |   13 ++++++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
...

>> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
>> index 553d6d6..30fcea1 100644
>> --- a/drivers/mtd/ofpart.c
>> +++ b/drivers/mtd/ofpart.c
>> @@ -20,6 +20,10 @@
>>   #include <linux/slab.h>
>>   #include <linux/mtd/partitions.h>
>>   +static bool node_has_compatible(struct device_node *pp)
>> +{
>> +       return of_get_property(pp, "compatible", NULL);
>> +}

Missing a trivial additional newline here. I amended the patch in l2-mtd.git.

>>   static int parse_ofpart_partitions(struct mtd_info *master,
>>                                    struct mtd_partition **pparts,
>>                                    struct mtd_part_parser_data *data)

...

Brian
