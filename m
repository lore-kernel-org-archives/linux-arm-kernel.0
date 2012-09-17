From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 14:26:06 -0700
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <alpine.DEB.2.00.1209162033400.698@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
 <alpine.DEB.2.00.1209162033400.698@utopia.booyaka.com>
Message-ID: <20120917212605.GC11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120916 13:37]:
> On Tue, 11 Sep 2012, Paul Walmsley wrote:
> 
> > Then the branch was PM-tested to determine whether it can suspend and 
> > serial-resume properly, and whether dynamic idle works.  These tests 
> > didn't go so well:
> > 
> > - 3530ES3 Beagleboard here was able to enter retention-idle
> >   suspend, and leave it with serial wakeup, but the CORE powerdomain never 
> >   entered a low-power state.  Dynamic retention-idle with serial wakeup
> >   never resumed, and the test stopped there:
> > 
> >   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3530es3beagle/3530es3beagle_log.txt
> > 
> > - 37xx EVM and 3730 Beagle XM fared better; they made it through the whole 
> >   test program, but the CORE powerdomain also never entered a low-power
> >   state:
> > 
> >   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/37xxevm/37xxevm_log.txt
> >   http://www.pwsan.com/omap/testlogs/common_clk_testing_devel_3.7/20120911000742/boot/3730beaglexm/3730beaglexm_log.txt
> 
> Thanks to debugging work by some TI LDC engineers, these two issues have 
> been resolved.  Some clockdomain associations had been removed that were 
> necessary for the OMAP power management code to function correctly.  The 
> obvious ones have been restored to the clock data, and the branch updated.

That's good news. Does that mean we should try to merge these patches
for v3.7 then? Or do we still have issues remaining?

Regards,

Tony
