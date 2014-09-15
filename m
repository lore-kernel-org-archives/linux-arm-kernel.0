From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 14 Sep 2014 21:31:16 -0700
Subject: [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20140911153739.GA24416@localhost>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <20140911132935.068DCC408F6@trevor.secretlab.ca>
 <20140911153739.GA24416@localhost>
Message-ID: <20140915043116.9985CC407E8@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Sep 2014 16:37:39 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Sep 11, 2014 at 02:29:34PM +0100, Grant Likely wrote:
> > Regarding the requests to refactor ACPICA to work better for ARM. I
> > completely agree that it should be done, but I do not think it should be
> > a prerequisite to getting this core support merged. That kind of
> > refactoring is far easier to justify when it has immediate improvement
> > on the mainline codebase, and it gives us a working baseline to test
> > against. Doing it the other way around just makes things harder.
> 
> I have to disagree here. As I said, I'm perfectly fine with refactoring
> happening later but I'm not happy with compiling in code with undefined
> behaviour on ARM that may actually be executed at run-time.
> 
> I'm being told one of the main advantages of ACPI is forward
> compatibility: running older kernels on newer hardware (potentially with
> newer ACPI version tables). ACPI 5.1 includes partial support for ARM
> but the S and C states are not defined yet. We therefore assume that
> hardware vendors deploying servers using ACPI would not provide such
> yet to be defined information in ACPI 5.1 tables.

We're good on this front. ACPI-future platforms aren't allowed to use
new features when booting an older kernel. ACPI has a mechanism to check
version numbers. Similarly, when ACPI-future defines those states, the
kernel shouldn't expose them to an older platform.

> What if in a year time we get ACPI 5.2 or 6 (or an errata update)
> covering the S and C states for ARM? I would expect hardware vendors
> to take advantage and provide such information in ACPI tables. Can we
> guarantee that a kernel with the current ACPI patches wouldn't blow up
> when it tries to interpret the new tables?

Yes - at least as much as we can guarantee anything in systems
programming.

g.
