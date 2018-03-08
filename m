From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 8 Mar 2018 18:01:53 +0100
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd> <20180308132139.apabmgw4magrp3d7@pali>
 <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
Message-ID: <20180308170153.376gcwwudwkq3gs7@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 March 2018 13:35:49 Marc Zyngier wrote:
> On 08/03/18 13:21, Pali Roh?r wrote:
> > On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> >> Hi!
> >>
> >>> Resent without non-upstream patches.
> >>>
> >>> This backport patchset fixed the spectre issue, it's original branch:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> >>> A few dependency or fixingpatches are also picked up, if they are necessary
> >>>  and no functional changes.
> >>>
> >>> No bug found from kernelci.org and lkft testing. It also could be gotten from:
> >>>
> >>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
> >>>
> >>> Comments are appreciated!
> >>
> >> Not entirely related to this patched, but... I have few older ARM
> >> boards here, and Nokia N9000 I really care about.
> >>
> >> AFAICT Meltdown is arm64 only?
> > 
> > IIRC ARMv7 is not affected by meltdown.
> > 
> >> Spectre affects the older boards, too, right? Was there any work done
> >> on that? cpuinfo says "ARMv7" for N900.
> > 
> > I remember that I saw some spectre patches for ARMv7 on LKML.

This is that patch series:
https://www.spinics.net/lists/arm-kernel/msg632065.html

> > In general for ARMv7 it is problematic as mitigation needs to change IBE
> 
> Not quite. IBE is part of ACTLR, which is an implementation defined
> register, so generalizing this statement to "ARMv7" is plain wrong. Case
> in point: A9, A12/A17 do not need any bit to be set. A8 needs IBE to
> allow BPIALL to work, A15 needs it for ICIALLUI to perform a BP
> invalidation.

Ok, Nokia N900 has Cortex A8.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/4838585f/attachment.sig>
