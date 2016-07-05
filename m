From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 5 Jul 2016 09:48:34 -0400
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <577B54CE.90004@samsung.com>
References: <57737761.2020708@samsung.com>
 <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
 <577A1D54.9010203@samsung.com>
 <98eb9718-1267-dafe-2e36-323f4976ece0@osg.samsung.com>
 <577B54CE.90004@samsung.com>
Message-ID: <913d98f6-0d7c-63e3-8748-961eafd776f4@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/05/2016 02:33 AM, Krzysztof Kozlowski wrote:
> On 07/04/2016 05:15 PM, Javier Martinez Canillas wrote:

[snip]

>>
>> Yes, splitting the lock per controller will fix the possible deadlock in
>> this case but I think we need an approach that is safe for all possible
>> scenarios. Otherwise it will work more by coincidence than due a design.
> 
> This is not a coincidence. This design is meant to fix this deadlock.
> Not by coincidence. By design.
>

Ok, if the configurations I described doesn't exist in practice and are
just theoretical then yes, doing a per controller lock is a good design. 
 
> You are talking about theoretical different configurations... without
> even real bug reports. I am providing an idea to fix a real deadlock and
> your argument is that it might not fix other (non-reported) deadlocks.
> These other deadlocks happen now as well probably...
>

I'm not against you re-working the locks to do it per controller, is just
that I thought it would be good to have a solution that is going to work
for all possible scenarios.

You asked for comments/opinions/ideas and I gave mine, that's all :)

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
