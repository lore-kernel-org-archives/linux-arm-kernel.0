From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Aug 2014 10:23:08 +0100
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FED13C.4070606@ahsoftware.de>
References: <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
 <20140827103432.64927C409CB@trevor.secretlab.ca>
 <20140827144403.GB13850@arm.com> <53FE05AE.9000406@wwwdotorg.org>
 <53FE07BE.7000809@ahsoftware.de> <53FE0966.5020206@wwwdotorg.org>
 <53FED13C.4070606@ahsoftware.de>
Message-ID: <20140828092308.GA31111@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 07:50:36AM +0100, Alexander Holler wrote:
> Am 27.08.2014 18:37, schrieb Stephen Warren:
> > Of course, there are probably cases where we could/should add some more
> > phandles/... and likewise cases where we shouldn't. That's why detailed
> > research is needed.
> 
> Just because I'm curious, I wonder how this research does or shoud look 
> like.
> 
> Defered probes did come to light with 3.4, that was more than 2 years 
> ago. Ok, most people (like me) just noticed it during the last months 
> when they switched to DT and have run into a problem (the deferred probe 
> mechanism is an error-message killer), but some must have seen it 
> already 2 years ago.
> 
> And I wonder how the ACPI world solves that problem. My guess would be 
> hardcoded stuff in the firmware-blob (BIOS), just like it happened with 
> board files, but I've never seen BIOS code and my knowledge about ACPI 
> is almost zero. ;)

ACPI doesn't even attempt to solve such problems at the OS level. SoCs
aimed at ACPI should have simple hardware configuration (from a Linux
perspective) initialised by firmware (e.g. clocks) and devices living on
a standard bus like PCIe. If a SoC requires specific low-level code to
initialise the hardware in a specific order (other than architected
peripherals like GIC, timers; e.g. MFD devices), we should deem it
unsuitable for ACPI.

ACPI should only be used by vendors who know exactly why they need and
how to implement it properly and not just because the marketing
department told them to (it would also be nice if the Linux kernel
community was informed about such reasons).

-- 
Catalin
