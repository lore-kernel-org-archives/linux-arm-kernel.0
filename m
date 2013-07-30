From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 29 Jul 2013 20:49:31 -0400
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <alpine.DEB.2.02.1307291739150.13736@nftneq.ynat.uz>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
 <alpine.DEB.2.02.1307291739150.13736@nftneq.ynat.uz>
Message-ID: <CAKON4Ow2KMC_9xod3Ay51Yetg9RbfMxVcy4DH0A3baHpmxP+7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 8:41 PM, David Lang <david@lang.hm> wrote:
> On Mon, 29 Jul 2013, Jason Cooper wrote:
>
>>
>>>
>>> I don't think that siblings have any defined order in DT.  If reading a
>>> device tree, there's no guarantee you get nodes or properties out in the
>>> same order as the original .dts file.
>>
>>
>> That's why I raised the point.  If people think encoding initialization
>> order in the DT is a good idea, then we should change the dtc so it
>> compiles/decompiles in the same order.
>
>
> if you make the initializaiton order 'magicly' correct by following the
> order of the flat representation, how do you reflect the case where
> initialization can be overlapped for different devices?

I agree with David, using DT to try and eliminate deferred probes
isn't a good solution.  Overlapped probes and doing probes on multiple
CPUs introduces a temporal angle to the problem. Best to just let the
deferred probing code dynamically solve the problem. From what I can
see the deferred probing solution is working out nicely.

Plus there isn't that much code being run in deferred probing. I
suspect potential savings (if there even is any) are under a
millisecond.

>
> you are just trading one side of the problem for the other.
>
> David Lang



-- 
Jon Smirl
jonsmirl at gmail.com
