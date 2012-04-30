From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 30 Apr 2012 19:41:23 +0000
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <alpine.DEB.2.00.1204271804010.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260246170.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA00AC6@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204271804010.10308@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA0CAFE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 05:34:53, Paul Walmsley wrote:
> On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > On Thu, Apr 26, 2012 at 14:19:28, Paul Walmsley wrote:
> > > looking at Table 1-1 "Device Features" of SPRUH73D, it seems that some 
> > > AM33xx family chips come with some features disabled, such as the 
> > > PRU-ICSS, the SGX, Ethernet, or USB.  How will this affect the clock tree?  
> > > For example, is it correct for us to include the PRU-ICSS clock control on 
> > > a clock tree that is booted on an AM3352 or an AM3354?
> > 
> > I thought of this, but if you look at the existing way of handling such 
> > Si version based clock registration is supported by "cpu_clkflg", like 
> > CK_3XXX, CK_AM35XX, etc...
> > 
> > During my baseport patch submission, Tony had removed CK_AM33XX flag while 
> > merging them. I believe, we are trying to get rid of these flags, and that's 
> > where Tony had removed them form my baseport patch.
> > I was not sure on how to handle this, so I decided to continue with full 
> > chip support (AM3358 and AM3359).
> 
> Okay, no problem.  Sounds like we should start with full support and then 
> remove clocks later if they cause problems on the lower-end devices.
> 
> 

That's my plan too.

Thanks,
Vaibhav
