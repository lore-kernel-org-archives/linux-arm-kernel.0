From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Jan 2014 11:46:16 +0000
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <52DCE790.6080809@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <201401171521.35940.arnd@arndb.de> <52DCE790.6080809@linaro.org>
Message-ID: <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
> On 2014-1-17 22:21, Arnd Bergmann wrote:
> > On Friday 17 January 2014, Hanjun Guo wrote:
> >>
> >> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>
> >> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> >> name from the ACPI timer table is matched with all the registered
> >> timer controllers and matching initialisation routine is invoked.
> > 
> > I wouldn't anticipate this infrastructure to be required. Shouldn't all
> > ARMv8 machines have an architected timer?
> 
> I not sure of this, could anyone can give some guidance? if only arch
> timer is available for ARM64, this will make thing very simple.

All ARMv8 systems should have an architected timer.

However, they may also have other timers (e.g. global timers for use
when CPUs are in low power states and their local architected timers
aren't active).

Thanks,
Mark.
