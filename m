From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Oct 2014 16:49:19 +0200
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <5447C276.4050106@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5447C276.4050106@free-electrons.com>
Message-ID: <20141022164919.4f4f4acf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 22 Oct 2014 16:43:02 +0200, Gregory CLEMENT wrote:

> On 22/10/2014 15:34, Ezequiel Garcia wrote:
> > This series adds support for the 25 MHz reference clock available on
> > Armada 375 SoC to use on the timer and watchdog drivers. It is
> > similar to the one present in Armada XP SoC.
> 
> I agree with Thomas P. comments: could you see if it was possible to reuse the same
> function and dt bindings that the ones used for Armada XP ?
> I am not aware of any difference between Armada XP and Armada 375 for this IP.

Well, there's one difference: on Armada XP we don't need to support the
"old" Device Tree, which didn't had the fixed 25 Mhz clock input
described.

So either we decide that it was a mistake due to an early version of
the 375 and we skip backward DT compatibility. Or we need in some way a
different logic than Armada XP, because Armada XP doesn't have this
backward compatibility requirement.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
