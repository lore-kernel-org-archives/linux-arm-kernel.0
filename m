From: johan@kernel.org (Johan Hovold)
Date: Sat, 11 Oct 2014 11:38:19 +0200
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
In-Reply-To: <20141010175409.GL31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141010175409.GL31348@saruman>
Message-ID: <20141011093819.GA18988@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 12:54:22PM -0500, Felipe Balbi wrote:
> HI,
> 
> On Thu, Oct 09, 2014 at 09:06:22PM +0200, Johan Hovold wrote:
> > This series fixes a few issues with the omap rtc-driver, cleans up a bit
> > and finally adds support for the PMIC control feature found in some
> > revisions of this RTC IP block.
> > 
> > Ultimately, this allows for powering off the Beaglebone and waking it up
> > again on RTC alarms.
> > 
> > I noticed yesterday that Lokesh Vutla recently posted some patches to
> > add regulator support to this driver. [1] While that series has some
> > issues that needs to be addressed, I still think it could be a good idea
> > to rebase my pmic_power_en patch on top of it as it adds some long
> > overdue device abstraction. That would be needed anyway in order to
> > support the new power-off infrastructure that's in the pipe in a clean
> > way. [2]
> 
> is this power-off feature "RTC-only mode" ?

Yes, I believe so, at least as long as RTC power is maintained. The
pmic_power_en pin can otherwise still be used to power off. 

On the BeagleBone the PMIC can be configured to enter OFF or SLEEP mode
on power off, where the latter (and default) mode keeps the RTC power
supply enabled.

Thanks for the fast review, Felipe.

Johan
