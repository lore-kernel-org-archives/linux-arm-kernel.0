From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 12:10:04 -0300
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <20141022164919.4f4f4acf@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<5447C276.4050106@free-electrons.com>
 <20141022164919.4f4f4acf@free-electrons.com>
Message-ID: <5447C8CC.7080306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 11:49 AM, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Wed, 22 Oct 2014 16:43:02 +0200, Gregory CLEMENT wrote:
> 
>> On 22/10/2014 15:34, Ezequiel Garcia wrote:
>>> This series adds support for the 25 MHz reference clock available on
>>> Armada 375 SoC to use on the timer and watchdog drivers. It is
>>> similar to the one present in Armada XP SoC.
>>
>> I agree with Thomas P. comments: could you see if it was possible to reuse the same
>> function and dt bindings that the ones used for Armada XP ?
>> I am not aware of any difference between Armada XP and Armada 375 for this IP.
> 
> Well, there's one difference: on Armada XP we don't need to support the
> "old" Device Tree, which didn't had the fixed 25 Mhz clock input
> described.
> 

Indeed.

> So either we decide that it was a mistake due to an early version of
> the 375 and we skip backward DT compatibility. Or we need in some way a
> different logic than Armada XP, because Armada XP doesn't have this
> backward compatibility requirement.
> 

Backward DT compatibility is a must. For instance, patches can be merged
through different routes (which has already happened) and you can break
things badly.

It doesn't worth the risk, for something that can be solved by just
implementing things carefully.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
