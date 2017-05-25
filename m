From: m.brock@vanmierlo.com (Maarten Brock)
Date: Thu, 25 May 2017 11:27:50 +0200
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <b5a032c8-db86-c16b-750f-10aa2a132248@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
 <20170523210710.4e84dd2d@alans-desktop>
 <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
 <20170524143108.682a548d@alans-desktop>
 <b5a032c8-db86-c16b-750f-10aa2a132248@xilinx.com>
Message-ID: <af6f5a938ea9807b708356790e0f53e1@vanmierlo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-24 18:09, Michal Simek wrote:
> On 24.5.2017 15:31, Alan Cox wrote:
>>> I am not saying that config option is perfect solution. It is at 
>>> least
>>> aligned with 5 others serial drivers in the tree.
>> 
>> And the fact people keep doing hacks jutifies continuing to make a 
>> mess.
>> Especialy as in this case it's entirely theoretical. Nobody has 
>> produced
>> actual hardware that hits the limit. Nobody has filed a bug, nobody is
>> impacted.
> 
> This is the reason why we are talking about it how to do it right.
> 
> With this ps uart it is not that easy because this is cadence RTL which
> is not in public IP database but the same think is with uartlite.
> Limit there is 16. If you really want that I can create that HW design
> which will require more than 16 uartlites in one design.
> 
> 
>> Creating extra CONFIG_ entries for junk like this is ridiculous, most 
>> of
>> the others at least have the excuse of being old code.
> 
> No doubt about it. I am just trying to find out what's the way you are
> suggesting.

A patch was already recently sent to this mailing list to add a CONFIG_
entry for the maximum number of uartlite devices. It is, as you say, 
quite
easy to create a device with more than 16 uartlite devices. (It is
probably harder to create one with many Cadence RTL PS uarts since that
would require a license.)

IMHO it is quite normal for anyone using the uartlite to build his/her 
own
kernel. and thus make config settings. But it is cumbersome to have to
modify the kernel sources. If the number of uartlites could be retrieved
from the device tree that would probably be even better if the price in
complexity and code size is reasonable.

Maarten
