From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Sep 2014 14:49:22 +0100
Subject: [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20140911132935.068DCC408F6@trevor.secretlab.ca>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <20140911132935.068DCC408F6@trevor.secretlab.ca>
Message-ID: <20140911134922.GG6158@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Thu, Sep 11, 2014 at 02:29:34PM +0100, Grant Likely wrote:
> On Mon,  1 Sep 2014 22:57:38 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > ACPI 5.1 has been released and now be freely available for
> > download [1]. It fixed some major gaps to run ACPI on ARM,
> > this patch just follow the ACPI 5.1 spec and prepare the
> > code to run ACPI on ARM64.
> > 
> > ACPI 5.1 has some major changes for the following tables and
> > method which are essential for ARM platforms:
> > 1) MADT table updates.
> > 2) FADT updates for PSCI
> > 3) GTDT
> > 
> > This patch set is the ARM64 ACPI core patches covered MADT, FADT
> > and GTDT, platform board specific drivers are not covered by this
> > patch set, but we provide drivers for Juno to boot with ACPI only
> > in the follwing patch set for review purpose.

[...]

> I've read through this entire series now. In my mind, aside from a few
> comments that I know you're addressing, this is ready.  The hooks into
> arm64 core code are not terribly invasive, it is nicely organized and
> manageable. Get the next version out ASAP, but I would also like to see
> the diffs from this version to the next so I don't need to review the
> entire series again.
> 
> Regarding the requests to refactor ACPICA to work better for ARM. I
> completely agree that it should be done, but I do not think it should be
> a prerequisite to getting this core support merged. That kind of
> refactoring is far easier to justify when it has immediate improvement
> on the mainline codebase, and it gives us a working baseline to test
> against. Doing it the other way around just makes things harder.
> 
> I would really like to see the next version of this series go into
> linux-next. I think this is ready for some wider exposure. Have you got
> a branch being pulled into Fengguang's autobuilder yet?

Apart from build testing, what does this wider exposure achieve? Is there a
platform available that would be able to boot Linux (to a meaingful state)
with this patch series alone?

I'm mindful of merging arch code that I'm unable to test, so I'd really
rather it was merged along with the code (and a devicetree) for a platform
that can use it.

Will
