From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Dec 2016 10:15:53 +0200
Subject: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
In-Reply-To: <20161028233750.GQ16026@codeaurora.org>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
Message-ID: <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/16 02:37, Stephen Boyd wrote:
> On 10/28, Tero Kristo wrote:
>> Eventually that should happen. However, we have plenty of legacy
>> code still in place which depend on clk_get functionality within
>> kernel. The major contributing factor is the hwmod codebase, for
>> which we have plans to:
>>
>> - get this clock driver merged
>> - implement a new interconnect driver for OMAP family SoCs
>> - interconnect driver will use DT handles for fetching clocks,
>> rather than clock aliases
>> - reset handling will be implemented as part of the interconnect
>> driver somehow (no prototype / clear plans for that as of yet)
>> - all the hwmod stuff can be dropped
>>
>> The clock alias handling is still needed as a transition phase until
>> all the above is done, then we can start dropping them. Basically
>> anything that is using omap_hwmod depends on the clock aliases right
>> now.
>
> Ok, sounds good. Thanks.

Stephen, any final comments on this series? I guess its too late to push 
for 4.10, but I would like to get this merged early for 4.11 window.

-Tero
