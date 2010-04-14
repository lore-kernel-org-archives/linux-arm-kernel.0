From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 14 Apr 2010 18:03:10 +0300
Subject: [PATCH 1/2] [ARM] pxa: add minimal ULPI functionality for USB
	host port 2 on PXA310.
In-Reply-To: <q2of17812d71004131547n8a2384b5ta345e70997017acb@mail.gmail.com>
References: <cover.1270651775.git.grinberg@compulab.co.il>
	<fa93111b71cf1e43eef23869466072be4db67bcd.1270651775.git.grinberg@compulab.co.il>
	<20100413220642.GW30801@buzzloop.caiaq.de>
	<q2of17812d71004131547n8a2384b5ta345e70997017acb@mail.gmail.com>
Message-ID: <4BC5D92E.7060408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/14/10 01:47, Eric Miao wrote:
> On Wed, Apr 14, 2010 at 6:06 AM, Daniel Mack <daniel@caiaq.de> wrote:
>   
>> On Wed, Apr 07, 2010 at 06:05:22PM +0300, Igor Grinberg wrote:
>>     
>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>> ---
>>>  arch/arm/mach-pxa/Makefile      |    1 +
>>>  arch/arm/mach-pxa/pxa310-ulpi.c |  240 +++++++++++++++++++++++++++++++++++++++
>>>  arch/arm/mach-pxa/pxa310-ulpi.h |   85 ++++++++++++++
>>>  3 files changed, 326 insertions(+), 0 deletions(-)
>>>  create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c
>>>  create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.h
>>>       
>> The USB OTG/ULPI framework could well be reused for that I think. All
>> that you would need is a struct otg_io_access_ops with two function
>> pointers to read and write registers. Then you can use otg_ulpi_create()
>> to set up an ULPI compliant device connected to the bus.
>>
>>     
> Right, that's what I'm thinking as well esp. since ULPI is a standard
> (ok, kinds of) and I'm not seeing too much specialty of pxa3xx ULPI
> except for the way to access registers. Cannot remember the detail
> but the OTG might be a hybrid model on pxa310, and might be a
> little bit different from others.
>
>   
Eric, Daniel,

Thanks for the comments.
So, the only right way is to patch OHCI to support the
otg_io_access_ops, isn't it?
Ok. I'll send a v2 in a couple of days.

Thanks,
Igor
