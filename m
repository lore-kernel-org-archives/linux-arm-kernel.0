From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 14:59:27 +0100
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1797489.PjmKzBFdQA@wuerfel>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
Message-ID: <3538097.dWBy3R9lty@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 11:20:01 Catalin Marinas wrote:
> On Mon, Jan 05, 2015 at 08:16:30PM +0000, Arnd Bergmann wrote:
> > On Monday 05 January 2015 13:13:02 Catalin Marinas wrote:
> > > > since passing no DT tables to OS but
> > > > acpi=force is missing is a corner case, we can do a follow up patch to
> > > > fix that, does it make sense?
> > > 
> > > Not entirely. Why would no dtb and no acpi=force be a corner case? I
> > > thought this should be the default when only ACPI tables are passed, no
> > > need for an additional acpi=force argument.
> > 
> > We don't really support the case of only ACPI tables for now. The expectation
> > is that you always have working DT support, at least for the next few years
> > as ACPI features are ramping up, and without acpi=force it should not try
> > to use ACPI at all.
> 
> So if both DT and ACPI are present, just use DT unless acpi=force is
> passed. So far I think we agree but what I want to avoid is always
> mandating acpi=force even when the DT tables are missing (in the long
> run).
> 
> Now, what's preventing a vendor firmware from providing only ACPI
> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
> that both DT and ACPI are supported, or at least that dts files are
> merged in the kernel first?

We have no way of enforcing what a board vendor ships, so if they want
to have ACPI-only machines for MS Windows, they just won't work by
default on Linux. Once ACPI support is mature enough, we can also
have a whitelist or a different default for using it automatically
when no DT is present.

For drivers merged upstream, I would insist that every driver merged
for an ARM64 platform has a documented DT binding that is used in the
driver.

	Arnd
