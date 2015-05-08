From: s-anna@ti.com (Suman Anna)
Date: Fri, 8 May 2015 14:13:33 -0500
Subject: [PATCH] ARM: OMAP2+: PRM: Fix am437x module reset
In-Reply-To: <alpine.DEB.2.02.1505081749320.19833@utopia.booyaka.com>
References: <1430508422-64913-1-git-send-email-d-gerlach@ti.com>
 <alpine.DEB.2.02.1505081749320.19833@utopia.booyaka.com>
Message-ID: <554D0ADD.1000304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 05/08/2015 12:50 PM, Paul Walmsley wrote:
> Hi Dave 
> 
> On Fri, 1 May 2015, Dave Gerlach wrote:
> 
>> When moving to using the OMAP4+ PRM driver on am437x, we switched
>> to using all omap4 ops for module reset management. However, reset
>> register layout on am437x is more similar to am335x than omap4 because
>> of the the need for an st_shift for the *_RST bits in certain *_RSTST
>> registers, like WKUP_PROC_LRST in the PRCM_RM_WKUP_RSTST. Without this
>> we cannot bring the Wakeup M3 IP out of reset.
>>
>> Because of this, we must use the am33xx prm ops for the hardreset
>> functionality while continuing to use all other omap4 ops. To accomplish
>> this we split out the common portion of omap44xx_prm_init and add an
>> am437x_prm_init to register the prm_ll_data struct specific to am437x.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> I'm assuming this has been superseded by Tero's patches.  If not, please 
> let me know.

Yep, thats right. You can drop/ignore this patch, we did miss Tero's
PRCM cleanup when this patch was rebased.

regards
Suman
