From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 19:53:24 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408171417.GB27776@obsidianresearch.com>
References: <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate> <20140408171417.GB27776@obsidianresearch.com>
Message-ID: <20140408175324.GH11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Apr 08, 2014 at 11:14:17AM -0600, Jason Gunthorpe wrote:
> The mbus hardware requires a power of two size, if a non-power
> of two is passed in to the low level routines they configure the
> register in a way that results in undefined behaviour.
> 
> - WARN_ON to make this invalid usage really obvious
> - Round down to the nearest power of two so we only stuff a valid
>   size into the HW

So if I understand it right, for example when my first NIC registers
e0000000-e02fffff, then we'll truncate it down to e0000000-e01fffff,
won't that cause any issue, for example if the NIC needs to access
data beyond that limit ?

BTW I can try your patch with the myricom NIC which started to work
when rounding up, I'll quickly see if that fixes the issue as well,
but I'm now a little bit confused.

Regards,
Willy
