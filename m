From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Feb 2012 10:22:38 +0100
Subject: [PATCH 5/6 V2] atmel/nand: add DT support
In-Reply-To: <20120207115306.GF15647@game.jcrosoft.org>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
 <4F30FD4B.4050501@atmel.com> <20120207115306.GF15647@game.jcrosoft.org>
Message-ID: <4F43625E.7070908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 12:53 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:30 Tue 07 Feb     , Nicolas Ferre wrote:
>> On 02/06/2012 11:35 AM, Jean-Christophe PLAGNIOL-VILLARD :
>>> use a local copy of board informatin and fill with DT data
>>>
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: linux-mtd at lists.infradead.org
>>
>> [..]
>>
>>> +static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
>>> +					 struct device_node *np)
>>
>> Maybe you will need to protect this function in case of !DT builds: I
>> suspect that some of the of_xxxxx() calls are not provided if !CONFIG_OF.
> no-need on the of_ function are static inline it !CONFIG_OF

Sorry to come back to this but:

of_get_nand_ecc_mode(np);
of_get_nand_on_flash_bbt(np);

for example are not available in case of non-DT compilation: so we must
protect the atmel_of_init_port() against this error.

Can you please rework another patch.

Bye,
-- 
Nicolas Ferre
