From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 17 Mar 2015 15:30:04 +0100
Subject: [update][PATCH v10 06/21] ACPI / sleep: Introduce
 CONFIG_ACPI_GENERIC_SLEEP
In-Reply-To: <20150317123536.GB14984@red-moon>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org>
 <10995588.scpoK3KRg2@vostro.rjw.lan> <20150317123536.GB14984@red-moon>
Message-ID: <2398042.a98hWjBeFo@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 17, 2015 12:35:36 PM Lorenzo Pieralisi wrote:
> On Tue, Mar 17, 2015 at 03:23:11AM +0000, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > Do you mean remove CONFIG_ACPI_GENERIC_SLEEP and
> > > 
> > > +acpi-$(CONFIG_ACPI_SLEEP) += sleep.o
> > > 
> > > as well (also need to remove duplicate #ifdef CONFIG_ACPI_SLEEP in sleep.c if
> > > we doing so)?
> > 
> > Well, almost.  There is one problem with that, becuase sleep.c contains code
> > outside of the ACPI_SLEEP-dependent blocks.  That code is used for powering
> > off ACPI platforms.
> > 
> > I guess you don't want that code on ARM too, right?
> > 
> > Perhaps we can use ACPI_REDUCED_HARDWARE_ONLY for that?  ARM64 will be the
> > only arch setting it at least for the time being, is that correct?
> 
> HW reduced only platforms are still required to support sleep
> states that on arm64 are totally meaningless at present, so I do
> not think ACPI_REDUCED_HARDWARE_ONLY will cut it.
> 
> Factoring out power_off methods from sleep.c ? I know, it is not nicer
> since you split the S-states management in multiple files.
> 
> Side note: is the acpi_suspend() function in sleep.c used in the kernel ?

No, it isn't.  I've just sent a patch to drop it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
