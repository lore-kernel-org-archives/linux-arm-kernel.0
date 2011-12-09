From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 9 Dec 2011 10:10:33 +0800
Subject: [GIT PULL] sa1100 fixes for 3.2
In-Reply-To: <20111208212048.GL14542@n2100.arm.linux.org.uk>
References: <CAN1soZyDCb8BqjTZ3N7kJBspQQtGuBchQYRbr2qcY1J24zCfuw@mail.gmail.com>
 <201112081649.23956.arnd@arndb.de>
 <20111208212048.GL14542@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZyCKaLfHZR3gN2_x4C8GbXXWiBq0aG33MeNoqJmUs4LAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 5:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 08, 2011 at 04:49:23PM +0000, Arnd Bergmann wrote:
>> I'm a bit confused about who I should be pulling from pxa and mmp stuff
>> in general. I've taken the liberal approach so far and just pulled whatever
>> gets thrown at me as long as it looks good from each of you, but the
>> MAINTAINERS file currently lists:
>>
>> PXA2xx/PXA3xx SUPPORT
>> M: ? ? ?Eric Miao <eric.y.miao@gmail.com>
>> M: ? ? ?Russell King <linux@arm.linux.org.uk>
>> PXA168 SUPPORT
>> M: ? ? ?Eric Miao <eric.y.miao@gmail.com>
>> M: ? ? ?Jason Chagas <jason.chagas@marvell.com>
>> PXA910 SUPPORT
>> M: ? ? ?Eric Miao <eric.y.miao@gmail.com>
>> MMP2 SUPPORT (aka ARMADA610)
>> M: ? ? ?Haojian Zhuang <haojian.zhuang@marvell.com>
>> M: ? ? ?Eric Miao <eric.y.miao@gmail.com>
>>
>> Should that be updated to include you for all of these? I certainly don't
>> want to step on Eric's and Russell's toes but you seem to be doing the bulk
>> of the pxa/mmp work nowadays and I would prefer to pull from someone
>> who is actually listed as maintainer.
>
> Eric no longer works for Marvell, but does what he can to look after PXA
> stuff. ?I can't really claim to be a 'maintainer' for PXA, but I still do
> some work in this area mostly in an advisory role.
>
> Jason doesn't seem to be contactable by any means (even his personal
> cell phone number and work number don't get him - though I do get his
> voicemail) and I've been worried about this for a number of months -
> even Haojian seems unable to contact Jason.
>
> Haojian is now the contact within Marvell for PXA/MMP stuff, so can be
> regarded as valid to pull from.
>
> If Haojian wishes to send a patch adding to the MAINTAINERS entries as
> appropriate, then I'd support that.

Sure. I can update the MAINTAINERS entries. I'll merge
PXA168/PXA910/MMP2 into one entry. I'll append my git tree and update
Eric's git tree.

The patch is pasted in below. If it's acceptable, I'll merge it into
my for-next branch.

Best Regards
Haojian


>From 55fa92e305755274e72f52059f9303caa455a38a Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Fri, 9 Dec 2011 09:58:41 +0800
Subject: [PATCH] MAINTAINERS: update pxa and mmp

Merge PXA168, PXXA910 and MMP2 together. Add Haojian as maintainer of
both arch-pxa and arch-mmp. Haojian's git tree is also added.

Update Eric's tree since the original one is obsolte.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 MAINTAINERS |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9ae02a..2c1ee8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5300,7 +5300,10 @@ F:       drivers/media/video/pvrusb2/
 PXA2xx/PXA3xx SUPPORT
 M:     Eric Miao <eric.y.miao@gmail.com>
 M:     Russell King <linux@arm.linux.org.uk>
+M:     Haojian Zhuang <haojian.zhuang@marvell.com>
 L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:     git git://github.com/hzhuang1/linux.git
+T:     git git://git.linaro.org/people/ycmiao/pxa-linux.git
 S:     Maintained
 F:     arch/arm/mach-pxa/
 F:     drivers/pcmcia/pxa2xx*
@@ -5310,25 +5313,14 @@ F:      include/sound/pxa2xx-lib.h
 F:     sound/arm/pxa*
 F:     sound/soc/pxa

-PXA168 SUPPORT
-M:     Eric Miao <eric.y.miao@gmail.com>
-M:     Jason Chagas <jason.chagas@marvell.com>
-L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
-S:     Maintained
-
-PXA910 SUPPORT
+MMP SUPPORT
 M:     Eric Miao <eric.y.miao@gmail.com>
-L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
-S:     Maintained
-
-MMP2 SUPPORT (aka ARMADA610)
 M:     Haojian Zhuang <haojian.zhuang@marvell.com>
-M:     Eric Miao <eric.y.miao@gmail.com>
 L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
+T:     git git://github.com/hzhuang1/linux.git
+T:     git git://git.linaro.org/people/ycmiao/pxa-linux.git
 S:     Maintained
+F:     arch/arm/mach-mmp/

 PXA MMCI DRIVER
 S:     Orphan
-- 
1.7.4.1


                                           1,1           Top
