From: Hamish.Martin@alliedtelesis.co.nz (Hamish Martin)
Date: Mon, 7 Mar 2016 20:04:51 +0000
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <CAAEAJfDyZELBkwNOkjPzGpg_gv-sDOkOSQV76c3WniCuEhveFw@mail.gmail.com>
Message-ID: <56DDDEE2.6010405@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 03/04/2016 01:03 PM, Ezequiel Garcia wrote:
> On 3 March 2016 at 17:16, Hamish Martin
> <Hamish.Martin@alliedtelesis.co.nz> wrote:
>> Hi Ezequiel,
>>
>> I'm glad my analysis was correct and we more fully understand the
>> problem now. CONFIG_PREEMPT seems to work for us now, but it does seem
>> like the wrong fix, and if you guys think it will not guarantee
>> preventing the issue then we'd rather back that change out.
>>
> Do you have any good reason for NOT enabling CONFIG_PREEMPT?
>
> I've had very bad experiences on embedded systems when not
> using CONFIG_PREEMPT, and came to the conclusion that
> enable full preemption, unless there's a good reason not to.
>
> Enabling CONFIG_PREEMPT would result in slightly lower throughput,
> but maximum latency will be greatly reduced.
>
> For instance, in a kernel without preemption, a UBI static volume check
> (which happens on the first UBI static volume open call), can take
> several seconds.
We don't have a good reason, it is mainly an historic artifact. We are 
happy to go with that as a fix and we are investigating it for other 
platforms too. I think it is an oversight that hasn't been given the 
thought it should.
I think we still need to consider operation of the driver without 
CONFIG_PREEMPT enabled.

>
>> I had contemplated using wait_for_completion_interruptible() but was a
>> bit unsure if it was safe. Do you have a proposed patch? We would be
>> happy to apply it to our system, turn off CONFIG_PREEMPT, and see how it
>> goes. Out issue is highly reproducible so I think it would be a good
>> first test for a change?
>>
> Sure, I can try to cook a patch for you.
Thanks for your help with this guys. Send me the patch when you have one 
you want me to test out for you.

Cheers,
Hamish M.
