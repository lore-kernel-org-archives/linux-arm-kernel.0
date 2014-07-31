From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 31 Jul 2014 16:05:43 +0200
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53DA3D66.1030407@ti.com>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <53DA3613.9010305@ti.com> <53DA3C68.3020406@kpanic.de>
 <53DA3D66.1030407@ti.com>
Message-ID: <53DA4D37.4030408@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2014 14:58, Peter Ujfalusi wrote:
> On 07/31/2014 03:54 PM, Stefan Assmann wrote:
>>> Why would you do this? The point of a clock provider is that you can
>>> enable/disable the clock on demand. Here you enable the clock and leave it
>>> enabled for the rest of the time...
>>>
>>> clk-dra7-atl deals with similar issue
>>
>> The idea is to enable the clock by default to get the wifi working.
>> Sorry if I got it wrong.
> 
> You should have a clock driver for the 32K clock. The wifi driver should
> request and manage it's clocks via the clock API.
> 

If the clock does not get enabled the wifi driver wl12xx doesn't even
get probed. Which is my initial problem. Maybe I need to figure that out
first.

  Stefan
