From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 May 2014 13:08:16 +0300
Subject: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
In-Reply-To: <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
Message-ID: <536B5790.1050800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 05/08/2014 03:20 AM, Paul Walmsley wrote:
> Hi P?ter,
> 
> On Wed, 30 Apr 2014, Peter Ujfalusi wrote:
> 
>> Add HWMOD_SWSUP_SIDLE to flags.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> This patch could use a better changelog.  It would be ideal to understand 
> _why_ HWMOD_SWSUP_SIDLE is needed.  Is there a known hardware bug?  Or is 
> this simply based on practical observation, e.g., something bad happens if 
> the McPDM is not software-idled?

The same issue exists on OMAP5 as on OMAP4:

commit 12d82e4b0aa6c71f38b668a372f9a13f243207da
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Fri Jan 18 16:48:16 2013 -0700

    ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

    McPDM need to be configured to NO_IDLE mode when it is in used otherwise
    vital clocks will be gated which results 'slow motion' audio playback.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    [paul at pwsan.com: copy patch description into hwmod data comments]
    Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c

-- 
P?ter
