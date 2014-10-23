From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 23 Oct 2014 09:16:33 -0300
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <20141022155614.04d33791@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155614.04d33791@free-electrons.com>
Message-ID: <5448F1A1.9040404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 10:56 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Wed, 22 Oct 2014 10:34:40 -0300, Ezequiel Garcia wrote:
>> This series adds support for the 25 MHz reference clock available on
>> Armada 375 SoC to use on the timer and watchdog drivers. It is
>> similar to the one present in Armada XP SoC.
>>
>> Given we initially had access to only a very early SoC revision (A375 Z0)
> 
> Actually: s/Z0/Z1/.
> 
>> and due to a hardware issue, the timer and watchdog support was originally
>> submitted to use the core clock.
>>
>> Now that the A0 SoC revision is out, we can fix this and use the reference
>> clock. The reason for this change is that the core clock is subject to the
>> SSCG, so boards where SSCG is enabled exhibit a very large timer drift.
>>
>> To prevent any compatibility issues when booting with an older devicetree,
>> this series provides proper fall backs in each case.
> 
> You don't clearly state whether your patch series keep compatibility
> with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
> Z1. I'm fine with that, but then it means we should officially declare
> the Z1 support in mainline as dead, and get rid of the workarounds that
> applied only to 375 Z1.
> 

How many people have Z1 boards? And is someone actually using one for
something? Do we have any other reason to support Z1?

FWIW, a v3.18-rc1 kernel built with mvebu_v7_defconfig, silently stalls
in the middle of the boot on Z1. Had to remove lots of compile time
options to make it boot.

Before I start digging into this, maybe we can discuss your suggestion
to drop it. If nobody is booting this often enough, maybe nobody cares
about this, and it makes sense to drop the support?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
