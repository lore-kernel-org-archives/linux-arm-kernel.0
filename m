From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 09:50:38 -0500
Subject: [PATCHv4 23/33] CLK: OMAP: add interface clock support for OMAP3
In-Reply-To: <51F92898.3090206@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-24-git-send-email-t-kristo@ti.com>
 <51F820DF.1080306@ti.com> <51F92898.3090206@ti.com>
Message-ID: <51FA75BE.3080802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 10:09 AM, Tero Kristo wrote:
> On 07/30/2013 11:23 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>>> OMAP3 has interface clocks in addition to functional clocks, which
>> is it just OMAP3?
>
> Yea, only omap3 is using this code. Basically because there is control
> for the module specific interface clocks which is absent from omap4+.
> Personally I think modelling the interface clocks in the first place in
> kernel side was a bad idea, and should have just enabled all of them and
> enable autoidles for them at the same point.

Not all autoidles work unfortunately, which is why they got modelled :D 
some even have the weird tendency to hang up L3/L4 interconnect when the 
OCP statemachines required inside the IP block for the autoidle PRCM 
handshake has been, umm... "not well implemented" ;) forcing us to use 
S/w supervised mode of operations.


>
>>
>>> require special handling for the autoidle and idle status register
>>> offsets mainly.
>>
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>   drivers/clk/omap/Makefile    |    2 +-
>>>   drivers/clk/omap/clk.c       |    3 ++
>>>   drivers/clk/omap/interface.c |  110
>>> ++++++++++++++++++++++++++++++++++++++++++
>> should this be isolated off for omap3?
>
> You mean within makefile or?

omap3-interface-clock.c or something more sensible and Makefile? I dont 
really have any strong opinions on this anyways.. interface.c is fine 
with me as well as the nodes are not probed unless compatible flags are 
set..

just trying to save a few bits in code space by building only if OMAP3 
is present.. /me shrugs..


-- 
Regards,
Nishanth Menon
