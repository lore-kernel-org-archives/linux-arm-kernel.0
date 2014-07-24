From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Jul 2014 08:29:02 +0200
Subject: [PATCHv3 2/7] ARM: mvebu: extend PMSU code to support dynamic
 frequency scaling
In-Reply-To: <20140723235026.6419.93364@quantum>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140723235026.6419.93364@quantum>
Message-ID: <20140724082902.0e64d454@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Turquette,

On Wed, 23 Jul 2014 16:50:26 -0700, Mike Turquette wrote:

> >  * registers the frequency operating points supported by the CPU;
> > 
> >  * registers a clock notifier of the CPU clocks. The notifier function
> 
> Where does this code register a clock notifier callback?
> 
> >    listens to the newly introduced APPLY_RATE_CHANGE event, and uses
> 
> I don't see APPLY_RATE_CHANGE referenced.

Yes, this is a mistake of the commit log, due to remains of the v2 of
the patch series. Back in the v2, there was indeed a new clock notifier
being used. But Stephen Boyd argued against that, and instead suggested
to use a direct function call, which this v3 implements, as stated in
the cover letter:

 - As suggested by Stephen Boyd, instead of using a new clock notifier
   that somewhat "hides" the dependency of the clk-cpu clock driver on
   the PMSU, use a direct call from the clk-cpu driver to the PMSU
   driver.

The commit log of this commit was not adjusted consequently, and this
is my fault. Jason, is it still time to change this commit log?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
