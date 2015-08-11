From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 11 Aug 2015 22:12:37 +0200
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
In-Reply-To: <55CA5567.9010002@caviumnetworks.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
 <20150811.114908.1384923604512568161.davem@davemloft.net>
 <55CA5567.9010002@caviumnetworks.com>
Message-ID: <20150811201237.GW4914@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.08.15 13:04:55, David Daney wrote:
> >In the future it might be better structured to try and get the OF
> >node, and if that fails then try and use the ACPI method to obtain
> >these values.
> 
> Our current approach, as you can see in the patch, is the opposite.  If ACPI
> is being used, prefer that over the OF device tree.
> 
> You seem to be recommending precedence for OF.  It should be consistent
> across all drivers/sub-systems, so do you really think that OF before ACPI
> is the way to go?

If ACPI is enabled then no OF function may be called at all.

With !ACPI or acpi=no kernel parameter, then acpi_disabled is set and
no ACPI function should be called. It always falls back to and only
uses OF/devicetree in this case.

So there is now way to try devicetree first and then use acpi or vice
versa. There is no mixup using acpi or devicetree with the same boot,
either one or the other.

-Robert
