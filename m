From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Tue, 9 Sep 2014 23:04:23 +0100
Subject: [PATCH v3 03/17] ARM64 / ACPI: Introduce lowlevel suspend function
In-Reply-To: <20140909163529.GA6370@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-4-git-send-email-hanjun.guo@linaro.org>
 <20140909163529.GA6370@arm.com>
Message-ID: <20140909220423.GL6558@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 05:35:29PM +0100, Catalin Marinas wrote:
> On Mon, Sep 01, 2014 at 03:57:41PM +0100, Hanjun Guo wrote:
> > From: Graeme Gregory <graeme.gregory@linaro.org>
> > 
> > acpi_wakeup_address is used on x86 as the address bios jumps into
> > when machine wakes up from suspend. As arm64 does not have such a
> > bios this mechanism will be provided by other means. But the define
> > is still required inside the acpi core.
> > 
> > Introduce a null stub for acpi_suspend_lowlevel as this is also
> > required by core. This will be filled in when standards are
> > defined for arm64 ACPI global power states.
> 
> Do we actually plan to use these on arm64? I'm worried most of these
> don't make sense on arm64 (the aim is to use PSCI). Is it possible to
> refactor the core code so that we don't have to define dummy macros or
> variables just to be able to build the kernel?
> 
Currently ia64 does the same as this for stubbing out the functions.

We did investigate removing the code but that ultimately ended with more
functions and variables stubbed then this.

Graeme
