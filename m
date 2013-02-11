From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Feb 2013 04:58:30 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229B9573@DBDE01.ent.ti.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B9573@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1302110452010.6247@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Tero, Rajendra, Sricharan

Hi Keerthy,

On Mon, 11 Feb 2013, J, KEERTHY wrote:

> I understand that retention is broken from the logs.
> I first tried seeing if the retention is working without the patch
> And I see that even without the patch retention fails.
> 
> I am attaching the log.
> 
> I just want to confirm if the retention is working fine without
> Applying the patch on mainline.

Works for me on v3.8-rc7:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc7/20130210080644/pm/4460pandaes/4460pandaes_log.txt

You're probably using a bootloader that's too old.  In your log, you're 
using u-boot 2012.04.  According to R Sricharan, u-boot 2012.07 or later 
is needed.  Unfortunately, we're missing code in the kernel to reset 
on-chip devices that the bootloader enables on OMAP4.  See:

http://www.spinics.net/lists/arm-kernel/msg218641.html

http://marc.info/?l=linux-omap&m=136019427719813&w=2


- Paul
