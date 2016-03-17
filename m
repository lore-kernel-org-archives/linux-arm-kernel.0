From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Mar 2016 16:03:08 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160317153747.GD11623@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
 <56EAC40F.1080504@codeaurora.org>
 <20160317153747.GD11623@e104818-lin.cambridge.arm.com>
Message-ID: <56EAD53C.80707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/16 15:37, Catalin Marinas wrote:
> On Thu, Mar 17, 2016 at 09:49:51AM -0500, Timur Tabi wrote:

[...]

>> Keep in mind that on an ACPI system like ours, the boot loader (UEFI in our
>> case) configures the system extensively.  It does a lot of things that the
>> kernel would normally do on a device tree system.  For example, pin control
>> is handled completely by UEFI.  The kernel does not set the pin muxes or
>> GPIO directions.  That means we don't support dynamic pin muxing.  Before
>> the kernel is booted, the GPIO pins are fixed.
> 
> And that's great. But you are mistaken in thinking that DT requires lots
> of drivers in the kernel and prevents the firmware from doing sane
> stuff. DT rather gained additional features out of necessity since the
> firmware was not always doing a proper job at hardware initialisation.
> A DT-enabled kernel does not impose restrictions on such firmware
> features. With ACPI, the choice is not as wide and forces vendors to
> look into their firmware story from a different angle (until they figure
> the _DSD+PRP0001 out and we end up with DT emulated in ACPI).

Or even worse, perverting the couple of things that were actually OK in
ACPI by inventing a new layer of broken stuff:

http://thread.gmane.org/gmane.linux.ports.arm.msm/17828

Once we've reached that level, _DSD fells all nice and cuddly.

	M.
-- 
Jazz is not dead. It just smells funny...
