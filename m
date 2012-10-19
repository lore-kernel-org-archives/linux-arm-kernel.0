From: stigge@antcom.de (Roland Stigge)
Date: Fri, 19 Oct 2012 13:51:12 +0200
Subject: [PATCH RFC 02/15 v5] gpio: Add sysfs support to block GPIO API
In-Reply-To: <CACRpkda35jKs9YVNDAo96=0QzdMi+jkvJAzM=nX+HCK-d5+e9Q@mail.gmail.com>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
 <1350477107-26512-3-git-send-email-stigge@antcom.de>
 <20121017190520.GC25996@kroah.com> <507FD4EB.1080204@antcom.de>
 <CACRpkda35jKs9YVNDAo96=0QzdMi+jkvJAzM=nX+HCK-d5+e9Q@mail.gmail.com>
Message-ID: <50813EB0.9040102@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 12:35 PM, Linus Walleij wrote:
> On Thu, Oct 18, 2012 at 12:07 PM, Roland Stigge <stigge@antcom.de> wrote:
>> On 10/17/2012 09:05 PM, Greg KH wrote:
>>>>
>>>> +    if (value != exported) {
>>>> +            if (value)
>>>> +                    status = gpio_block_value_export(block);
>>>> +            else
>>>> +                    status = gpio_block_value_unexport(block);
>>>
>>> That looks like a recipie for disaster.  Why do you allow userspace to
>>> do this?
>>
>> Exporting for gpio blocks is done as follows: writing "1" to the
>> "exported" _device_ attribute of the gpio block creates the "values"
>> attribute and at the same time requests the whole block (including all
>> of its gpios) as "sysfs".
> 
> To me it reads like Greg's comment is basically pinpointing a flaw
> in Brownell's initial design of gpio sysfs: that new sysfs files are
> created and destroyed by writing into sysfs */export files from
> userspace?
> 
> See commit: d8f388d8dc8d4f36539dd37c1fff62cc404ea0fc
> 
> The block GPIO stuff is just following that design pattern.

So what do you think about my just proposed idea of always having the
"value" argument present, but only useable when "exported" is "1"? Now
only talking about the block gpios, but later maybe also for gpios?

But I would only do this if you and Greg consider it reasonable.

Thanks in advance,

Roland
