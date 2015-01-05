From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Jan 2015 11:05:33 +0000
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54A90A4C.60908@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
 <54A90A4C.60908@linaro.org>
Message-ID: <20150105110533.GA14967@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 04, 2015 at 09:39:24AM +0000, Hanjun Guo wrote:
> On 2014?12?25? 01:18, Catalin Marinas wrote:
> [...]
> >
> > In addition to the above and _DSD requirements/banning, I would also add
> > some clear statements around:
> >
> > _OSC: only global/published capabilities are allowed. For
> > device-specific _OSC we need a process or maybe we can ban them entirely
> > and rely on _DSD once we clarify the process.
> >
> > _OSI: firmware must not check for certain _OSI strings. Here I'm not
> > sure what we would have to do for ARM Linux. Reporting "Windows" does
> > not make any sense but not reporting anything can, as Matthew Garrett
> > pointed out, can be interpreted by firmware as "Linux". In addition to
> > any statements in this document, I suggest you patch
> > drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for ARM
> > and print a kernel warning so that we notice earlier.
> >
> > ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". It
> > doesn't make much sense in the ARM context. Could we change it to
> > "Linux" when CONFIG_ARM64?
> 
> We will work on this both on ASWG and linux ACPI driver side, as Dong
> and Charles pointed out, _OSI things can be solved in ACPI spec, when
> that is done, we can modify the kernel driver to fix the problems above.

Which driver?

What about ACPI_OS_NAME? Would you suggest it is fine to report
"Microsoft Windows NT" on an ARM system? That _OS_ not _OSI.

-- 
Catalin
