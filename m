From: davem@davemloft.net (David Miller)
Date: Tue, 11 Aug 2015 13:50:19 -0700 (PDT)
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
In-Reply-To: <20150811201237.GW4914@rric.localhost>
References: <20150811.114908.1384923604512568161.davem@davemloft.net>
 <55CA5567.9010002@caviumnetworks.com>
 <20150811201237.GW4914@rric.localhost>
Message-ID: <20150811.135019.576312282566025940.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <robert.richter@caviumnetworks.com>
Date: Tue, 11 Aug 2015 22:12:37 +0200

> On 11.08.15 13:04:55, David Daney wrote:
>> >In the future it might be better structured to try and get the OF
>> >node, and if that fails then try and use the ACPI method to obtain
>> >these values.
>> 
>> Our current approach, as you can see in the patch, is the opposite.  If ACPI
>> is being used, prefer that over the OF device tree.
>> 
>> You seem to be recommending precedence for OF.  It should be consistent
>> across all drivers/sub-systems, so do you really think that OF before ACPI
>> is the way to go?
> 
> If ACPI is enabled then no OF function may be called at all.

That makes no sense to me at all.

If ACPI is enabled, the OF routines should return no nodes etc.
