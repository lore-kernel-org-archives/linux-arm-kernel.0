From: ahs3@redhat.com (Al Stone)
Date: Sun, 11 Jan 2015 13:41:28 -0700
Subject: [RFC v2] ACPI on arm64 TODO List, 11 Jan 2015
Message-ID: <54B2DFF8.4020301@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update for 11 Jan 2015:

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


Changes since 14 Dec 2014:
-- v6 of ACPI core patches posted
-- Good progress in _OSI investigation, started preparing RFC for the
   mailing lists
-- Precise definition of kernel behavior when defaulting to DT and/or
   using acpi=force being discussed again
-- FWTS now runs and results posted after each merge of leg-kernel
   (includes ACPI) with Linus' tree (i.e., each -rc).
-- ACPI on arm64 kernel document updated, under extensive discussion on
   the lists; starting coordination with SBBR content.
-- Firmware Summit: planned for 26 Mar 2015, San Jose, CA, at the ARM
   office; mailing list (with archives) now up and running; updated
   agenda being prepared
-- Merged items "Demonstrate the ACPI core patches work", and "Platform
   support patches need review" because of their similarity.
-- Further discussions have occurred regarding "Why ACPI?"; Grant has
   a blog post explaining this better, and we will add that to kernel
   document
-- Further discussion on the usage of _DSD has occurred, but much more
   is needed


TODO List for ACPI on arm64:
============================
1. Define how Aarch64 OS identifies itself to firmware
   * Problem:
     * _OSI method is demonstrably unreliable. On x86, Linux claims to
       be Windows.
     * Proposal to use _OSC method as replacement is complicated and
       creates an explosion of combinations
   * Solution:
     * Draft and propose OS identification rules to ABST and ASWG for
       inclusion in ACPI spec.
     * Draft and propose recommended practice for current ACPI 5.1 spec
       platforms.
   * Status: Good progress in _OSI investigation, started preparing RFC
     for the mailing lists; general agreement to deprecate _OSI
     completely

2. Linux must choose DT booting by default when offered both ACPI and
   DT on arm64
   * Status: DONE, but being revisited for possible algorithmic change

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
   * Status:
     * LuvOS and FWTS ported to arm64; patches in mainline; additional
       test cases being written.
     * CI loop set up to run FWTS on Foundation model for each -rc
       merge of Linus' tree into leg-kernel.
     * AMD Seattle results pending updated kernel patches.
     * LuvOS details at https://wiki.linaro.org/LEG/Engineering/luvOS

4. Set clear expectations for those providing ACPI for use with Linux
   * Problem:
     * Hardware/Firmware vendors can and will create ACPI tables that
       cannot be used by Linux without some guidance
     * Kernel developers cannot determine whether the kernel or
       firmware is broken without knowing what the firmware should do
   * Solution: document the expectations, and iterate as needed.
     Enforce when we must.
   * Status: kernel text updated and under heavy discussion, AMD has
     made their guidance document available, and starting to coordinate
     content with SBBR; firmware summit date and location seems firm,
     agenda being updated.

5. Platform support patches need verification and review
   * Problem: the core Aarch64 patches have been reviewed and are in
     good shape, but there is not yet a good example of server platform
     support patches that use them.
   * Solution: post *good* patches for multiple ACPI platforms,
     demonstrating that both the core patches work, and that the use of
     the ACPI core makes sense.
   * Status:
     * ACPI core works on at least the Foundation model, Juno, APM
       Mustang, and AMD Seattle
     * FWTS results for the Foundation model have been posted
     * First version for AMD Seattle has been posted to the public
       linaro-acpi mailing list for initial review, refined versions to
       be posted to broader lists after a few iterations for basic
       cleanup

6. How does the kernel handle_DSD usage?
   * Problem:
     * _DSD defines key-value properties in the DT style. How do we
       ensure _DSD bindings are well defined?
     * How do we ensure DT and _DSD bindings remain consistent with
       each other?
   * Solution: public documentation for all bindings, and a process for
     defining them
   * Status: proposal to require patch authors to point at public
     binding documentation; kernel Documentation/devicetree/bindings
     remains the default if no other location exists; UEFI forum has
     set up a binding repository. Discussion continues.

7. Why is ACPI required?
   * Problem:
     * arm64 maintainers still haven't been convinced that ACPI is
       necessary.
     * Why do hardware and OS vendors say ACPI is required?
   * Solution: discussions between those who want ACPI and arm64
     maintainers
   * Status: Grant has provided a blog post at
     http://www.secretlab.ca/archives/151.  Al will roll that content
     into the kernel documentation, also.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
