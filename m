From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 14:33:22 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
Message-ID: <4FB25B22.4070605@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 14:10, Lior Amsalem wrote:

>>> +}
>>> +
>>> +static const char * const axp_dt_board_dt_compat[] = {
>>> +	"marvell,axp-db",
>>> +	NULL,
>>
>> This is where the device support becomes confusing.
>>
>> I would strongly advise on using "mrvl,mv78230" as the binding name. It isn't
>> as if you can't have multiple names associated with one binding.
>>
>> Also, given how close they are, do we really need separate machine support
>> files?
> The problem with 78230 is that it's only one flavor of the AXP family which
> includes 78230, 78260 and 78460 resulting different core count, L2 size, DRAM bandwidth, etc.

The number of cores is discoverable from the cpu scu and the
rest should either be encoded into the device-tree as either
specific device names or node properties.

I would try and involve the _minimum_ number of additions to get
the system up and running.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
