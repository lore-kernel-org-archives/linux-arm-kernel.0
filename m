From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Jan 2015 13:13:02 +0000
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54A28B22.7090305@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
 <54A28B22.7090305@linaro.org>
Message-ID: <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 11:23:14AM +0000, Hanjun Guo wrote:
> On 2014?12?25? 01:18, Catalin Marinas wrote:
> > On Fri, Oct 17, 2014 at 02:37:14PM +0100, Hanjun Guo wrote:
> >> +Booting using ACPI tables
> >> +-------------------------
> >> +The only defined method for passing ACPI tables to the kernel on ARMv8
> >> +is via the UEFI system configuration table.
> >> +
> >> +Processing of ACPI tables may be disabled by passing acpi=off on the kernel
> >> +command line; this is the default behavior.  If acpi=force is used, the kernel
> >> +will ONLY use device configuration information contained in the ACPI tables.
> >
> > See my comments to Al around the defaults. I think if only ACPI tables
> > are present, we shouldn't panic the kernel if acpi=force is missing but
> > continue with ACPI.
> 
> I think we need another patch to implement it, for this patch set,kernel
> will panic if no dtb and acpi=off.

If no dtb and acpi=off on the kernel command line, I agree that the
kernel should panic as it doesn't have any way to get the platform
description.

> since passing no DT tables to OS but
> acpi=force is missing is a corner case, we can do a follow up patch to
> fix that, does it make sense?

Not entirely. Why would no dtb and no acpi=force be a corner case? I
thought this should be the default when only ACPI tables are passed, no
need for an additional acpi=force argument.

-- 
Catalin
