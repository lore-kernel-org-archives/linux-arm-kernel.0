From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jun 2016 11:23:17 +0100
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
Message-ID: <20160607102317.GC2633@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:06:39PM +0900, Itaru Kitayama wrote:
> Upstream v4.7-rc2 kernel does not boot if parameter acpi is set to force
> on Overdrive. (acpi=off gets to the prompt)

Did acpi=force work on this board with an earlier kernel (e.g. v4.6)?

> When set to force it doesn't get to the Linux boot process and stalls.

What output do you get before it stalls?

I assume that you at least have output from the EFI stub?

Which command line options are you passing?

If you get nothing after the stub, try also passing:

earlycon=pl011,0xe1010000

Which may give an indication of what's going on.

> Here's the BIOS info:
> 
> Version 2.17.1249. Copyright (C) 2015 American Megatrends, Inc.
> BIOS Date: 09/03/2015 13:52:32 Ver: ROD0084E00

I don't know if the FW from a year ago provided everything necessary. It
may be something like the SPCR is simply missing, and there's no
console= passed to the kernel.

Thanks,
Mark.
