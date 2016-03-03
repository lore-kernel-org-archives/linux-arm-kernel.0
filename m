From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Mar 2016 13:13:13 +0200
Subject: [PATCH 10/11] ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
In-Reply-To: <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
 <56D5C6B1.6040005@ti.com>
 <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
Message-ID: <56D81C49.6030706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 03/01/2016 07:01 PM, Paul Walmsley wrote:
>>> 2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't set it 
>>> for McASP4-8.  Could you please confirm that this is intentional, and if 
>>> so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look 
>>> identical.
>>
>> I need to confirm this, but all McASP should have the same set of flags.
> 
> OK.  Looking at McASP3 data this morning, they probably shouldn't need 
> HWMOD_SWSUP_SIDLE, but probably all need 
> 
>                         .modulemode   = MODULEMODE_SWCTRL,
> 
>>> 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be 
>>> "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
>>
>> I need to check this, but I don't think McASP1,2,3 can be bus-master onto L3.
> 
> OK.  When you get back, maybe doublecheck this - it looks to me from 
> SPRUHZ6 that McASP1-3 have built-in DMA controllers.

They are only targets on L3. Not sure about the built-in DMA controller

> 
>> I can resend the series next week as I'm out of office this week.
> 
> That's fine.  It's most likely v4.7 material at this point.
> 
> 
> - Paul
> 


-- 
P?ter
