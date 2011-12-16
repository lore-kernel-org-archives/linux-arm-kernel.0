From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 16 Dec 2011 17:51:20 +0530
Subject: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
In-Reply-To: <alpine.DEB.2.00.1112160422150.12660@utopia.booyaka.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
 <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com>
 <4ED85835.7080108@ti.com>
 <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
 <alpine.DEB.2.00.1112160422150.12660@utopia.booyaka.com>
Message-ID: <4EEB37C0.1070307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2011 04:53 PM, Paul Walmsley wrote:
> Hi
>
> On Fri, 16 Dec 2011, Paul Walmsley wrote:
>
>> + * XXX Will not work correctly if the RM_*_CONTEXT register
>> + * offset is 0 -- probably a flag should be used to avoid this
>> + * situation, rather than testing @oh->prcm.omap4.context_offs.  No
>> + * return value.
>
> By the way, I'm also worried about this case.  Am wondering if we should
> add a flag here just to be sure, rather than testing the offset.
> Thoughts?

I am not sure if we even have any modules on OMAP4 which *do not*
support module level context loss status and for which we need to fall
back on pwrdm level status. So maybe we could even get rid of the check
for a valid context_offset altogether and expect it to be populated for
all modules as we do with the clkctrl offset.

>
>
> - Paul
