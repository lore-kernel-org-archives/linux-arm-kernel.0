From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 12 Jun 2012 19:06:26 +0800
Subject: [RFC PATCH] MTD: nand: add return value for write_page() function
 in structure of nand_ecc_ctrl.
In-Reply-To: <1339498176.2401.27.camel@sauron.fi.intel.com>
References: <1339153855-3761-1-git-send-email-josh.wu@atmel.com>
 <1339498176.2401.27.camel@sauron.fi.intel.com>
Message-ID: <4FD722B2.3080407@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

Thanks for the review.

On 6/12/2012 6:49 PM, Artem Bityutskiy wrote:
> On Fri, 2012-06-08 at 19:10 +0800, Josh Wu wrote:
>>   /**
>> + * nand_write_page_none - [INTERN] raw page writen function with return value
>> + * @mtd: mtd info structure
>> + * @chip: nand chip info structure
>> + * @buf: data buffer
>> + * @oob_required: must write chip->oob_poi to OOB
>> + */
>> +static inline int nand_write_page_none(struct mtd_info *mtd,
>> +                               struct nand_chip *chip,
>> +                               const uint8_t *buf, int oob_required)
>> +{
>> +       nand_write_page_raw(mtd, chip, buf, oob_required);
>> +
>> +       return 0;
>> +}
> Thanks!
>
> Would you please also make the wrtite_page_raw call-back return an error
> code - it is just strange to change '->write_page' and avoid changing
> '->write_page_raw'...

Ok. I'll do a version 2 patch that makes write_page_raw return an error 
code too.

>
> P.S. Not sure we still want these baroque header comments, but this is
> just a side note and separate issue.
>

If change the write_page_raw call back with return value. then I will 
remove all the function and comments.

Best Regards,
Josh Wu
