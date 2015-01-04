From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 04 Jan 2015 17:39:24 +0800
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
Message-ID: <54A90A4C.60908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?12?25? 01:18, Catalin Marinas wrote:
[...]
>
> In addition to the above and _DSD requirements/banning, I would also add
> some clear statements around:
>
> _OSC: only global/published capabilities are allowed. For
> device-specific _OSC we need a process or maybe we can ban them entirely
> and rely on _DSD once we clarify the process.
>
> _OSI: firmware must not check for certain _OSI strings. Here I'm not
> sure what we would have to do for ARM Linux. Reporting "Windows" does
> not make any sense but not reporting anything can, as Matthew Garrett
> pointed out, can be interpreted by firmware as "Linux". In addition to
> any statements in this document, I suggest you patch
> drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for ARM
> and print a kernel warning so that we notice earlier.
>
> ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". It
> doesn't make much sense in the ARM context. Could we change it to
> "Linux" when CONFIG_ARM64?

We will work on this both on ASWG and linux ACPI driver side, as Dong
and Charles pointed out, _OSI things can be solved in ACPI spec, when
that is done, we can modify the kernel driver to fix the problems above.

>
> Compatibility with older kernels: ACPI firmware must work, even though
> not fully optimal, with the earliest kernel version implementing the
> targeted ACPI spec. There may be a need for new drivers but otherwise
> adding things like CPU power management should not break older kernel
> versions. In addition, the ACPI firmware must also work with the latest
> kernel version.

It should be, and I think that's why we need ACPI (or DT) here :)

Thanks
Hanjun
