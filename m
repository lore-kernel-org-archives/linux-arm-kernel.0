From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Jun 2015 12:11:03 +0100
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
In-Reply-To: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150615111103.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 01:52:30PM +0200, Thomas Petazzoni wrote:
> The Cortex-A9 has a L1 prefetch capability documented at
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/Chdejhgd.html:
> 
>   The Cortex-A9 data cache implements an automatic prefetcher that
>   monitors cache misses done by the processor. This unit can monitor
>   and prefetch two independent data streams. It can be activated in
>   software using a CP15 Auxiliary Control Register bit. See Auxiliary
>   Control Register.
> 
> This commit enables this L1 prefetch feature unconditionally on all
> Cortex-A9 by setting bit 2 in the Auxiliary Control CP15
> register. Note that since this bit only exists on Cortex-A9 but not on
> Cortex-A5 or Cortex-R7, we separate the handling of Cortex-A9 from the
> one of those two other cores.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I'd prefer not to take this until after the next merge window, because I
don't want to deal with conflicts that this may cause with other branches
in my tree.

We're at -rc8 now, only a week away from -final, now is not really the
time to be taking new code into git trees anyway.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
