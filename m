From: peda@axentia.se (Peter Rosin)
Date: Thu, 10 Nov 2016 09:04:17 +0100
Subject: [PATCH v2] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <20161110000923.ltpouekbkx7onzm7@piout.net>
References: <20161020153535.7e2b4frcukk2ce2i@piout.net>
 <4e332daa-7d2a-1481-c8fc-7119033b68e3@axentia.se>
 <20161110000923.ltpouekbkx7onzm7@piout.net>
Message-ID: <889dcb3b-6702-d718-edf1-44a87197925b@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-10 01:09, Alexandre Belloni wrote:
> On 10/11/2016 at 00:41:37 +0100, Peter Rosin wrote :
>> On 2016-10-20 15:35, Alexandre Belloni wrote
>>> On 16/10/2016 at 18:21:45 +0200, Sylvain Rochet wrote :
>>>> Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
>>>> pullup is pointless.
>>>>
>>>> Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
>>>> floating and so consuming a useless extra amount of power in crowbarred
>>>> state if nothing is externally connected to dbgu.
>>> Applied, thanks.
>>
>> I can't seem to find this patch in any of the repos I'm looking at,
>> so I'm wondering where it was applied and when it might hit mainline?
>>
> 
> It is applied there:
> http://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/log/?h=at91-dt
> 
> It will land in 4.10. I'll do the PR to arm-soc soon.

Great, thanks! (expected it to be in -next by now and got worried, and
couldn't find it in https://github.com/linux4sam/linux-at91 either...)

Cheers,
Peter
