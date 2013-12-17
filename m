From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 17 Dec 2013 02:43:24 -0800
Subject: [PATCH v3 1/9] mtd: nand: davinci: fix driver registration
In-Reply-To: <52B02598.5060004@ti.com>
References: <1386264358-9738-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386264358-9738-2-git-send-email-ivan.khoronzhuk@ti.com>
 <20131217092449.GL12034@norris-Latitude-E6410>
 <52B02598.5060004@ti.com>
Message-ID: <CAN8TOE-DA8pQC2tt6M8ygGaioiDCvRqnwMU_GtWX6BR45Dvhhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 2:21 AM, ivan.khoronzhuk <ivan.khoronzhuk@ti.com> wrote:
> On 12/17/2013 11:24 AM, Brian Norris wrote:
>> On Thu, Dec 05, 2013 at 07:25:49PM +0200, Ivan Khoronzhuk wrote:
>>> --- a/drivers/mtd/nand/davinci_nand.c
>>> +++ b/drivers/mtd/nand/davinci_nand.c
>>> @@ -877,6 +877,7 @@ static int __exit nand_davinci_remove(struct platform_device *pdev)
>>>   }
>>>
>>>   static struct platform_driver nand_davinci_driver = {
>>> +    .probe          = nand_davinci_probe,
>>>      .remove         = __exit_p(nand_davinci_remove),
>>
>> I believe you need to drop the __exit_p() here. And now that you're
>> using module_platform_driver(), you need to drop the __init and __exit
>> from the probe() and remove() routines, to avoid section mismatch
>> warnings.
>
> Do you want me to drop it in stand alone patch or in this one?

I think you can just do the __exit_p()/__init/__exit removal all in
this same patch. The changes are all inter-related.

Brian
