From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 12 Jul 2013 11:27:36 +0200
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <51DED333.9080609@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
 <20130711145916.GA6138@kahuna> <51DED333.9080609@ti.com>
Message-ID: <51DFCC08.4050204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 05:45 PM, Peter Ujfalusi wrote:
>> We could get rid of all the #ifdef from the code that way. OMAP3 is the
>> only platform that still depends on this - Further, with this change,
> 
> Yep, I can do that. I'll send a separate patch to do this.

Now that I have looked at this: we might need to wait a bit and clean up other
files first: if we compile twl-common only if OMAP3 is selected, a build for
OMAP4/5 only will break due to missing symbol in pm.c (omap_pmic_late_init is
missing).
I could add another set of #ifdef there, but it defeats the point IMHO.

-- 
P?ter
