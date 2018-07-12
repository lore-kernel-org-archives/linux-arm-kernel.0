From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 12 Jul 2018 10:10:29 -0700
Subject: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
In-Reply-To: <CAFd5g47-Bq_wUkL4vP93si+urDs-A0j26ukZ+Riy24HWi5AuuA@mail.gmail.com>
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
 <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com>
 <c13fc12e859f7bdb300f08ad805cdf6d7ec09f52.camel@perches.com>
 <CAFd5g47-Bq_wUkL4vP93si+urDs-A0j26ukZ+Riy24HWi5AuuA@mail.gmail.com>
Message-ID: <41770e0f-c0ab-5fb7-6c8f-6cf4f80f01f0@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/12/2018 1:38 AM, Brendan Higgins wrote:
> On Wed, Jul 11, 2018 at 10:10 AM Joe Perches <joe@perches.com> wrote:
>>
>> On Wed, 2018-07-11 at 09:53 -0700, Jae Hyun Yoo wrote:
>>> On 7/10/2018 10:42 PM, Brendan Higgins wrote:
>>>> On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>>> There are some log printing without a newline character. This
>>>>> patch adds the missing newline characters.
>> []
>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> []
>>>>> @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>>>>            */
>>>>>           if (bus->master_state == ASPEED_I2C_MASTER_START) {
>>>>>                   if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>>>>> -                       pr_devel("no slave present at %02x", msg->addr);
>>>>> +                       pr_devel("no slave present at %02x\n", msg->addr);
>>>>
>>>> Unless something changed in the last couple versions of the kernel, this is the
>>>> only line that actually changes anything. dev_* inserts a newline for every
>>>> call.
>>
>> Not true.
>>
>> Any printk without KERN_CONT inserts a newline
>> if the last character
>> emitted is not a newline.
>>
>> dev_<level> uses can also be followed by pr_cont.
>>
>> So this patch does reduce the possibility of
>> interleaved messages from multiple processes.
> 
> My mistake. Thanks for pointing that out.
> 
> Jae, forget what I said earlier. This looks good to me.
> 

Okay. I'll keep this patch as is.
Thanks Joe for your clarification!
Thanks Brendan for your 'Reviewed-by' tag!

Jae
