From: robherring2@gmail.com (Rob Herring)
Date: Sat, 17 Aug 2013 11:24:13 -0500
Subject: [Ksummit-2013-discuss] [ARM ATTEND] DT maintainer
In-Reply-To: <20130815160628.GB32265@arm.com>
References: <CAL_JsqJpxeRbaZ4Uk4YNmN3w8D=XYf3VWX2c4NEqCy40zSdGSA@mail.gmail.com>
 <20130815160628.GB32265@arm.com>
Message-ID: <CAL_JsqK=cnbe4L2aX3-p8bEJ0g2eXQ9cUHx1r9CfkBLmq32M-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:06 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Aug 13, 2013 at 02:11:06PM +0100, Rob Herring wrote:
>> Other topics I'd like to discuss:
>> What's left for ARM consolidation work? What further work needed to
>> avoid arm64 duplication?
>
> We'll have a better idea once we see more arm64 hardware. In the
> meantime, what I know for sure is that we need a PCIe implementation
> that is able to share drivers/host/* code between arm and arm64 (and
> possibly other architectures). We had some attempts for more unification
> between arm64, powerpc, microblaze, mips
> (http://lkml.indiana.edu/hypermail/linux/kernel/1304.3/00698.html,
> http://www.linux-mips.org/archives/linux-mips/2013-07/msg00031.html) and
> work is ongoing.
>
>> Now that we are moving from just compiling multiple platforms together
>> to actually running them, what problems have been run into? Are there
>> issues around multi-platform kernels such as kernel size or need for
>> additional run-time patching?
>
> If size becomes an issue, the next step for multi-platform could be
> compiling as much SoC-related code as possible into loadable modules
> that can go into initramfs.

Yes, that is the obvious and easy first step. The challenge here are
the many inter-dependencies of modules needed at boot time like i2c,
gpio, regulators, pmic's, etc. Perhaps having something like
preloaded/built-in modules which are available at boot time, but could
be unloaded after boot if not needed. Special per machine linker
sections which could be freed are another option, but the trend seems
to be moving away from special sections like __devinit,

Rob
