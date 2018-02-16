From: david@lechnology.com (David Lechner)
Date: Fri, 16 Feb 2018 13:22:20 -0600
Subject: [PATCH 1/6] nand: davinci: rename the platform driver
In-Reply-To: <20180216201923.16bfca7f@bbrezillon>
References: <20180216164712.25898-1-brgl@bgdev.pl>
 <20180216164712.25898-2-brgl@bgdev.pl> <20180216201923.16bfca7f@bbrezillon>
Message-ID: <93fd5120-28c6-96c7-4a0d-a4bd065f5ae6@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2018 01:19 PM, Boris Brezillon wrote:
> On Fri, 16 Feb 2018 17:47:07 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
>> lookup table") broke the nand support in board file mode for
>> da850-based boards. Instead of reverting it and breaking the DT users
>> in the process (due to clock lookup), rename the driver to match the
>> clock table before renaming the users.
>>
>> Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/mtd/nand/davinci_nand.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>> index ccc8c43abcff..4fb143bf1872 100644
>> --- a/drivers/mtd/nand/davinci_nand.c
>> +++ b/drivers/mtd/nand/davinci_nand.c
>> @@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
>>   	.probe		= nand_davinci_probe,
>>   	.remove		= nand_davinci_remove,
>>   	.driver		= {
>> -		.name	= "davinci_nand",
>> +		.name	= "davinci-nand",
> 
> Another side-effect of this change you should be aware of: by doing
> that you also break all users that were defining partitions through the
> cmdline using mtdparts=davinci_nand.0:<part-layout>.
> 
> Not sure this is a good idea ;-).

Also, once we move to the common clock framework, the AUXDATA that causes
the DT clock lookup breakage you are trying to avoid will go away, so that
won't be a reason for changing this either.
