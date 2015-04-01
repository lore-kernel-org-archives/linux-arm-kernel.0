From: slash.tmp@free.fr (Mason)
Date: Wed, 01 Apr 2015 14:07:05 +0200
Subject: Reading twd_base at run-time
In-Reply-To: <20150327205301.GD4019@n2100.arm.linux.org.uk>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
Message-ID: <551BDF69.4020205@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/2015 21:53, Russell King - ARM Linux wrote:

> That's one scenario.  Here's the scenario Mark is describing - one which
> has real-world examples:
>
> Hardware engineer picks address A for rev A and sets CP15 to address A.
> Everything works.  Hardware engineer then picks address B for rev B, but
> forgets to update CP15.  It breaks.

The hardware engineer told me that whatever arbitrary value is chosen
for PERIPH_BASE is automatically exported through CP15 (which is how
I thought this worked). So there is no "forgetting to update CP15"
(for this platform, at least).

> If it's in DT, it can be fixed.  It should be there anyway as part of
> the hardware description.  DT is a description of the hardware.

I thought DT was supposed to describe hardware that /cannot/ be probed
or discovered at run-time?

If everything could be probed at run-time, what would be the point of DT?

(For my own reference, DT on x86)
http://thread.gmane.org/gmane.linux.kernel/1104014
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/x86/kernel/devicetree.c

Regards.
