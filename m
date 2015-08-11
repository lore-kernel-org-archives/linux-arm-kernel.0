From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 11 Aug 2015 13:04:55 -0700
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
In-Reply-To: <20150811.114908.1384923604512568161.davem@davemloft.net>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
 <20150811.114908.1384923604512568161.davem@davemloft.net>
Message-ID: <55CA5567.9010002@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 11:49 AM, David Miller wrote:
> From: David Daney <ddaney.cavm@gmail.com>
> Date: Mon, 10 Aug 2015 17:58:35 -0700
>
>> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
>>
>> The first patch (1/2) rearranges the existing code a little with no
>> functional change to get ready for the second.  The second (2/2) does
>> the actual work of adding support to extract the needed information
>> from the ACPI tables.
>
> Series applied.

Thank you very much.

>
> In the future it might be better structured to try and get the OF
> node, and if that fails then try and use the ACPI method to obtain
> these values.

Our current approach, as you can see in the patch, is the opposite.  If 
ACPI is being used, prefer that over the OF device tree.

You seem to be recommending precedence for OF.  It should be consistent 
across all drivers/sub-systems, so do you really think that OF before 
ACPI is the way to go?

Thanks,
David Daney
