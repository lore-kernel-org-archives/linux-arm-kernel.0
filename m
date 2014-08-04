From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 4 Aug 2014 11:09:20 -0500
Subject: [PATCHv9 1/3] mfd: altera: Add Altera SDRAM Controller
In-Reply-To: <20140802170811.GA20550@pengutronix.de>
References: <1406744573-609-1-git-send-email-tthayer@opensource.altera.com>
 <1406744573-609-2-git-send-email-tthayer@opensource.altera.com>
 <20140731082637.GH9030@lee--X1> <53DAA072.4010902@opensource.altera.com>
 <20140801081317.GL9030@lee--X1> <53DC146D.1070504@opensource.altera.com>
 <20140802170811.GA20550@pengutronix.de>
Message-ID: <53DFB030.1070406@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/02/2014 12:08 PM, Steffen Trumtrar wrote:
> Hi!
>
> On Fri, Aug 01, 2014 at 05:27:57PM -0500, Thor Thayer wrote:
>> On 08/01/2014 03:13 AM, Lee Jones wrote:
>>> On Thu, 31 Jul 2014, Thor Thayer wrote:
>>>> On 07/31/2014 03:26 AM, Lee Jones wrote:
>>>>> On Wed, 30 Jul 2014, tthayer at opensource.altera.com wrote:
> [...]
>
>>>>>> +u32 altera_sdr_readl(struct altera_sdr *sdr, u32 reg_offset)
>>>>>> +{
>>>>>> +	return readl(sdr->reg_base + reg_offset);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(altera_sdr_readl);
>>>>>> +
>>>>>> +void altera_sdr_writel(struct altera_sdr *sdr, u32 reg_offset, u32 value)
>>>>>> +{
>>>>>> +	writel(value, sdr->reg_base + reg_offset);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(altera_sdr_writel);
>> We'd prefer to use syscon and that is what we started with. If you'd
>> like to be our advocate, I will return to that because it was pretty
>> clean. My primary concern is to get it upstreamed and if it is MFD
>> then I'll make the changes.
>>
>> Here are the threads.
>> http://marc.info/?l=linux-kernel&m=140128791902800&w=2
> The conclusion of this thread was syscon for offset 0x0, no ?!
> And if you decide to have new writel/readl functions, I'd prefer if you don't
> change the order of parameters just because. That always weirds me out, when
> there are vendorname_writel functions, that only change the API of writel and
> nothing else (not exactly the case here).
Hi Steffen,

Yes, I see your point on the order of parameters. i will change it.

As for the syscon only at offset 0, I submitted that in version 7 & 8. 
It wasn't as clean as the version using syscon for the entire range.  It 
could also require changes to the SDRAM controller binding as things are 
added in the future.  My understanding is the bindings should not change 
significantly and changes are frowned upon.

After going through this exercise in a couple of different ways, I'm 
leaning toward using syscon for the entire SDRAM controller register range.

Is there a good reason not to use syscon on the entire register range?

Thanks,

Thor
>
> Regards,
> Steffen
>
