From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 1 Mar 2016 17:01:25 +0000 (UTC)
Subject: [PATCH 10/11] ARM: DRA7: hwmod: Add data for
 McASP1/2/4/5/6/7/8
In-Reply-To: <56D5C6B1.6040005@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
 <56D5C6B1.6040005@ti.com>
Message-ID: <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter,

On Tue, 1 Mar 2016, Peter Ujfalusi wrote:

> Hi Paul,
> 
> On 03/01/2016 11:11 AM, Paul Walmsley wrote:
> > Hi P?ter
> > 
> > A few questions:
> > 
> > On Thu, 25 Feb 2016, Peter Ujfalusi wrote:
> > 
> >> Add missing data for all McASP ports for the dra7 family
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > 1. The patch doesn't set the HWMOD_OPT_CLKS_NEEDED flag for McASP1 and 2, 
> > but does set it for McASP4-8.  Could you please confirm that this is 
> > intentional, and if so, why?
> 
> All should have the HWMOD_OPT_CLKS_NEEDED as both fclk and ahclkx is treated
> as functional clock and needs to be available in order to be able to access
> McASP registers.
> Sorry, I can only test McASP3 and somehow I overlooked this when copy-pasting
> the data.

OK

> > 2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't set it 
> > for McASP4-8.  Could you please confirm that this is intentional, and if 
> > so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look 
> > identical.
> 
> I need to confirm this, but all McASP should have the same set of flags.

OK.  Looking at McASP3 data this morning, they probably shouldn't need 
HWMOD_SWSUP_SIDLE, but probably all need 

                        .modulemode   = MODULEMODE_SWCTRL,

> > 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be 
> > "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
> 
> I need to check this, but I don't think McASP1,2,3 can be bus-master onto L3.

OK.  When you get back, maybe doublecheck this - it looks to me from 
SPRUHZ6 that McASP1-3 have built-in DMA controllers.

> I can resend the series next week as I'm out of office this week.

That's fine.  It's most likely v4.7 material at this point.


- Paul
