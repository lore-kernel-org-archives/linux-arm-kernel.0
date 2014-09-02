From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 15:42:53 +0200
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <20140902132651.GF27056@arm.com>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <20140901173245.GM2953@xora-haswell.xora.org.uk>
 <20140902132651.GF27056@arm.com>
Message-ID: <4816592.tj3on6vUaC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 14:26:52 Catalin Marinas wrote:
> 
> Not much at the KS, I think it will need to be followed up on lkml
> (https://lkml.org/lkml/2014/8/17/10 is the last I'm aware of, not sure
> about any updates in the meantime).
> 
> While the above gets sorted, what's the position from an ARM
> perspective (and covered by Documentation/arm64/arm-acpi.txt)? I think
> the "Device Enumeration" section in this document is fine, it's just the
> kernel infrastructure missing.
> 
> Alternatively, you can say _DSD is not allowed (yet?) but I don't
> particularly like basing the configuration on acpi_device_id like in
> this patch. Which would leave us with ignoring any SoC containing
> devices that require such specific configuration.

The way I recall the discussion, most people were on one extreme
side of the discussion or the other:

a) We should use _DSD for ARM64 servers to maximize code reuse with
DT-enabled drivers, work around the slow UEFI standardization process,
remain in control of the actual bindings, and avoid the need for
endless per-ID platform-data definitions in drivers.

b) We should never use _DSD at all, since doing that would have no
advantage over using DT directly, and we should force every device
manufacturer to specify their bindings in an official ACPI document
to prevent random incompatible bindings from being established.
Any device that shows up in servers should not need arbitrary detailed
properties anyway, as the details are supposed to be hidden in AML.

I can understand the reasons for both approaches, and I find it hard
to say either one is invalid. However, the worst possible outcome in
my opinion would be having to support a mix of the two.

	Arnd
