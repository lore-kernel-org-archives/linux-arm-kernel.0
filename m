From: al.stone@linaro.org (Al Stone)
Date: Mon, 15 Dec 2014 19:18:16 -0700
Subject: [RFC] ACPI on arm64 TODO List
Message-ID: <548F9668.6080900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back in September 2014, a meeting was held at Linaro Connect where we
discussed what issues remained before the arm64 ACPI core patches could
be merged into the kernel, creating the TODO list below.  I should have
published this list sooner; I got focused on trying to resolve some of
the issues instead.

We have made some progress on all of these items.  But, I want to make
sure we haven't missed something.  Since this list was compiled by only
the people in the room at Connect, it is probable we have.  I, for one,
do not yet claim omniscience.

So, I want to ask the ARM and ACPI communities:

  -- Is this list correct?

  -- Is this list complete?

Below is what we currently know about; very brief notes on status are
included.  The TL;DR versions of the TODO list and the current status
can be found at:

   https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/CoreUpstreamNotes

and I'll do my best to kept that up to date.

Thanks.  Any and all feedback is greatly appreciated.


TODO List for ACPI on arm64:
============================
1. Define how Aarch64 OS identifies itself to firmware.
   * Problem:
     * _OSI method is demonstrably unreliable. On x86 Linux claims to
       be Windows
     * Proposal to use _OSC method as replacement is complicated and
       creates an explosion of combinations
   * Solution:
     * Draft and propose OS identification rules to ABST and ASWG for
       inclusion in ACPI spec.
     * Draft and propose recommended practice for current ACPI 5.1 spec
       platforms.
   * Status: Little progress, still under investigation

2. Linux must choose DT booting by default when offered both ACPI and
   DT on arm64
   * DONE

3. Linux UEFI/ACPI testing tools must be made available
   * Problem:
     * Hardware/Firmware vendors do not have tools to test Linux
       compatibility.
     * Common problems go undetected if not tested for.
   * Solution:
     * Port FWTS tool and LuvOS distribution to AArch64
     * Make LuvOS images readily available
     * Require hardware vendors to actively test against old and new
       kernels.
   * Status: LuvOS and FWTS ported to arm64 and running; patches being
     mainlined; additional test cases being written.

4. Set clear expectations for those providing ACPI for use with Linux
   * Problem:
     * Hardware/Firmware vendors can and will create ACPI tables that
       cannot be used by Linux without some guidance
     * Kernel developers cannot determine whether the kernel or firmware
       is broken without knowing what the firmware should do
   * Solution: document the expectations, and iterate as needed.
     Enforce when we must.
   * Status: initial kernel text available; AMD has offered to make
     their guidance document generic; firmware summit planned for
     deeper discussions.

5. Demonstrate the ACPI core patches work
   * Problem: how can we be sure the patches work?
   * Solution: verify the patches on arm64 server platforms
   * Status:
     * ACPI core works on at least the Foundation model, Juno, APM
       Mustang, and AMD Seattle
     * FWTS results will be published as soon as possible

6. How does the kernel handle_DSD usage?
   * Problem:
     * _DSD defines key-value properties in the DT style. How do we
       ensure _DSD bindings are well defined?
     * How do we ensure DT and _DSD bindings remain consistent with
       each other?
   * Solution: public documentation for all bindings, and a process
     for defining them
   * Status: proposal to require patch authors to point at public
     binding documentation; kernel Documentation/devicetree/bindings
     remains the default if no other location exists; UEFI forum has
     set up a binding repository.

7. Why is ACPI required?
   * Problem:
     * arm64 maintainers still haven't been convinced that ACPI is
       necessary.
     * Why do hardware and OS vendors say ACPI is required?
   * Status: Al & Grant collecting statements from OEMs to be posted
     publicly early in the new year; firmware summit for broader
     discussion planned.

8. Platform support patches need review
   * Problem: the core Aarch64 patches have been reviewed and are in
     good shape, but there is not yet a good example of server platform
     support patches that use them.
   * Solution: Post *good* patches for multiple ACPI platforms
   * Status: first version for AMD Seattle has been posted to the
     public linaro-acpi mailing list for initial review (thanks,
     Arnd), refined versions to be posted to broader lists after a
     few iterations for basic cleanup

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
