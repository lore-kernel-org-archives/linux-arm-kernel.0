From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 8 Mar 2018 14:21:39 +0100
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <20180308122715.GB21514@amd>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd>
Message-ID: <20180308132139.apabmgw4magrp3d7@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> Hi!
> 
> > Resent without non-upstream patches.
> > 
> > This backport patchset fixed the spectre issue, it's original branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> > A few dependency or fixingpatches are also picked up, if they are necessary
> >  and no functional changes.
> > 
> > No bug found from kernelci.org and lkft testing. It also could be gotten from:
> > 
> > git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
> > 
> > Comments are appreciated!
> 
> Not entirely related to this patched, but... I have few older ARM
> boards here, and Nokia N9000 I really care about.
> 
> AFAICT Meltdown is arm64 only?

IIRC ARMv7 is not affected by meltdown.

> Spectre affects the older boards, too, right? Was there any work done
> on that? cpuinfo says "ARMv7" for N900.

I remember that I saw some spectre patches for ARMv7 on LKML.

In general for ARMv7 it is problematic as mitigation needs to change IBE
bit which is not possible on OMAP HS devices. But for Nokia N900 there
is special code which do it via smc instruction (function
rx51_secure_update_aux_cr(), see also nokia_n900_legacy_init()).

-- 
Pali Roh?r
pali.rohar at gmail.com
