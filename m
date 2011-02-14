From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 14 Feb 2011 08:18:07 +0200
Subject: [PATCH 2/2] ARM: tegra: add TrimSlice board
In-Reply-To: <AANLkTimU9tpeY3-5yisqOAKBeAtz684gtM2ieYb62zO-@mail.gmail.com>
References: <cover.1297063443.git.mike@compulab.co.il>	<c61e1816027e51acfb5bda1e498225a4da37d92d.1297063443.git.mike@compulab.co.il>	<AANLkTim5-dmpF8r9uZp8iDsT6p61D0iaJZuHvRLfUL6Y@mail.gmail.com>	<4D57BBC7.4070306@compulab.co.il>
	<AANLkTimU9tpeY3-5yisqOAKBeAtz684gtM2ieYb62zO-@mail.gmail.com>
Message-ID: <4D58C91F.9030303@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/11 21:06, Colin Cross wrote:
>>>
>>> Ack, the machine type is merged so I'll put this in for-next.  Do you
>>> want it enabled in tegra_defconfig?
>>
>> If 'select TEGRA_PCI' does not trouble you, I'd be glad to have the TrimSlice in
>> tegra_defconfig :)
> 
> My board without PCI doesn't boot if CONFIG_TEGRA_PCI is selected, so
> I guess it should stay off for now.  Any idea why it wouldn't boot?

The PCI subsystem should be re-gated, otherwise any access to PCI hangs the
system. Besides, on Harmony you need to enable two additional voltage supplies
to provide PEX_CLK voltage.
I'll send the patches that handle it, hopefully in the next few days.

-- 
Sincerely yours,
Mike.
