From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 13 Apr 2012 14:56:31 +0530
Subject: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
In-Reply-To: <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com>
 <1331659524-7635-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com>
 <4F8565C7.4080506@ti.com>
 <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Message-ID: <4F87F147.3040002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

>> >  While the patch did fix the issue for Anand, I guess it
>> >  was because of the additional delay post reset, waiting on the
>> >  RESETDONE bit and timing out, before accessing the i2c_con register.

I thought some more on this and the logic of the delay between the
SOFTRESET bit being set and an immediate register access did not make
much sense, because even polling on RESETDONE bit involves an immediate
i2c register access, albeit a different one.

I had a chat again with Anand this morning and realized the patch that
fixed the problems he saw on some customer hardware had changes from
both patch 1/2 and patch 2/2 from this series clubbed into one patch.
I seem to have split them into 2 patches later while posting it out
on the list.

So in all likelihood its the changes in patch 1/2 which made a
difference and the patch 2/2 was a result of my (wrong) analysis based
on code review.

The problems seen were extremely rare and not having access to those
few failing boards is making it difficult to re-validate with these
changes removed. However based on my analysis (hopefully right this time 
:)) it seems safe to revert this patch in mainline.

Should I go ahead and send a revert for the -rc?

regards,
Rajendra
