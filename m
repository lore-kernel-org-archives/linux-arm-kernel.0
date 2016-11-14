From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 14 Nov 2016 14:10:16 +0530
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <20161114141251.7ea86e7a@xhacker>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161114062145epcas5p10d8dc920fce008aa0d6c9388db94341a@epcas5p1.samsung.com>
 <20161114141251.7ea86e7a@xhacker>
Message-ID: <71596b86-7653-5c02-fc46-59409a91243f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jisheng,

On Monday 14 November 2016 11:42 AM, Jisheng Zhang wrote:
> Hi Pankaj,
> 
> On Mon, 14 Nov 2016 10:31:56 +0530 Pankaj Dubey wrote:

<snip>

>> +
>> +	np = of_find_matching_node(NULL, scu_match);
> 
> could we check np before calling of_iomap()?
> 

of_iomap takes care of that, and will return NULL if np is NULL.

So additional check of np is not required here.

>> +	scu_base = of_iomap(np, 0);
>> +	of_node_put(np);
>> +	if (!scu_base) {
>> +		pr_err("%s failed to map scu_base via DT\n", __func__);
> 
> For non-ca5, non-ca9 based SoCs, we'll see this error msg. We understand
> what does it mean, but it may confuse normal users. In current version,
> berlin doesn't complain like this for non-ca9 SoCs
> 

OK, let me see other reviewer's comment on this. Then we will decide if
this error message is required or can be omitted.


Thanks,
Pankaj Dubey
