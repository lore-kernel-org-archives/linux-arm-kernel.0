From: johan@kernel.org (Johan Hovold)
Date: Wed, 15 Oct 2014 19:06:28 +0200
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
In-Reply-To: <20141015165452.GB15770@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141015165452.GB15770@saruman>
Message-ID: <20141015170628.GA13824@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 11:55:02AM -0500, Felipe Balbi wrote:
> Hi,
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
> > 
> > So my suggestion is to merge the first seven patches, rebase Lokesh
> > series on top of that, and then I rebase my final five patches on top
> > of that in turn. Hopefully, the new power-off handler call chain will
> > have stabilised by then.
> 
> BTW, how do you test this series ?

Set a 30 second wakealarm using the sysfs attribute of the rtc class
device and power off the BBB:

	echo +30 >wakealarm; poweroff

Johan
