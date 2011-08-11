From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Aug 2011 11:48:07 -0500
Subject: [PATCH v2] gpio: pl061: add DT binding support
In-Reply-To: <20110811063637.GA3220@sapphire.tkos.co.il>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
	<1313011906-24161-1-git-send-email-robherring2@gmail.com>
	<20110811063637.GA3220@sapphire.tkos.co.il>
Message-ID: <4E4407C7.4040007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2011 01:36 AM, Baruch Siach wrote:
> Hi Rob,
> 
> On Wed, Aug 10, 2011 at 04:31:46PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds devicetree binding support to the ARM pl061 driver removing the
>> platform_data dependency. When DT binding is used, the gpio numbering is
>> assigned dynamically. For now, interrupts are not supported with DT until
>> irqdomains learn dynamic irq assignment.
>>
>> Rather than add another case of -1, updating the driver to use NO_IRQ.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> v2:
>> - Add other -1 to NO_IRQ conversions
> 
> Migrating existing pl061_platform_data users to NO_IRQ would be nice as well.  
> But this should probably be a separate patch.
> 

Actually, I expect we can kill off the platform_data once all users are
converted over to device tree.

> FWIW:
> 
> Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks.

Rob
