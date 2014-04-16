From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Apr 2014 10:44:53 +0200
Subject: [PATCH 0/5] fixing regressions caused by Dove in MULTI_V7
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140416104453.571c8d10@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Tue, 15 Apr 2014 20:15:58 +0200, Sebastian Hesselbarth wrote:

> Sebastian Hesselbarth (5):
>   ARM: iwmmxt: explicitly check for supported architectures
>   ARM: pj4: enable iWMMXt only if CONFIG_IWMMXT is set
>   ARM: pj4: properly detect existence of iWMMXt coprocessor
>   ARM: pj4: fix cpu_is_pj4 check
>   ARM: iwmmxt: allow to build iWMMXt on Marvell PJ4B

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>.

It does fix the boot on PJ4B-MP based processors that don't have iWMMXt
extensions such as the Armada XP. I've tested the following cases:

 * Armada XP (PJ4B-MP), with CONFIG_MACH_DOVE disabled and enabled
 * Armada 370 (PJ4B), with CONFIG_MACH_DOVE disabled and enabled

and all of them boot, while before your patch series, 3.15-rc1 fails to
boot on Armada XP with CONFIG_MACH_DOVE enabled.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
