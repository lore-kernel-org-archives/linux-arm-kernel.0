From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 16 Jul 2018 08:11:35 +0200
Subject: [Arm.ebbr-discuss] EBBR v0.6 Release Announcement
In-Reply-To: <be2fb34d-1813-a7e1-6ef0-4cfa7b135c39@arm.com>
References: <be2fb34d-1813-a7e1-6ef0-4cfa7b135c39@arm.com>
Message-ID: <0eb88541-c603-1dad-a500-b65d9bfa9075@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- ancient mailing list
+ proper u-boot mailing list.

M

On 14.7.2018 00:34, Grant Likely wrote:
> I'm pleased to announce the release of version 0.6 of the Embedded Base
> Boot Requirements (EBBR) specification.
> 
> ??? https://github.com/ARM-software/ebbr/releases/tag/v0.6
> 
> EBBR is a new specification defining a standard boot environment
> suitable for full feature operating systems running on embedded
> platforms...
> 
> Well, it will when it's finished.
> 
> It is well know that firmware for embedded systems is a fragmented area
> with each platform behaving in subtly incompatible ways. It is also
> completely different from the firmware interface used on general purpose
> desktops and servers. For OSes, this makes supporting more than a
> handful of platforms a nearly impossible affair. EBBR aims to solve this
> problem by defining a standard boot interface that can easily be
> implemented using either U-Boot or Tianocore, and is based on the same
> UEFI specification used on general purpose computers.
> 
> By adopting EBBR, platform vendors can reduce the amount of engineering
> effort required to support their products and make them easier to use.
> As EBBR is being developed in conjunction with the U-Boot, Tianocore,
> and Trusted Firmware projects, most of the functionality required is
> already implemented and ready to be used if one uses an up to date
> release of U-Boot or Tianocore.
> 
> For OS vendors, this makes far easier to support embedded platforms
> because they don't need to tailor the boot process for each platform.
> The same boot infrastructure works on both desktop/servers and on EBBR
> compliant embedded platforms.
> 
> And finally, for end users, working with an EBBR compliant platform
> means they can boot the OS of their choice without needing to learn low
> level details of the platform firmware.
> 
> This v0.6 release of EBBR is a pre-release document. The contents are
> not final. The purpose of this release is to raise awareness of the EBBR
> project, and to solicit feedback on the current draft. Please do read
> and provide comments on the boot-architecture at lists.linaro.org mailing
> list.
> 
> The plan is to release v1.0 before the end of the 2018.
> 
> Thanks to the EBBR committee members who contributed to this release:
> 
> ? Andreas F?rber (SUSE)
> ? Alex Graf (SUSE)
> ? Ryan Harkin (Linaro)
> ? Rob Herring (Linaro)
> ? Udit Kumar (NXP)
> ? Leif Lindholm (Linaro)
> ? Bill Mills (TI)
> ? Peter Robinson (Red Hat)
> ? Tom Rini (Konsulko)
> ? Daniel Thompson (Linaro)
> ? Dong Wei (Arm)
> 
> Sincerely,
> Grant Likely, EBBR committee co-chair
> 
> 
> Note on U-Boot implementations
> ------------------------------
> It is expected that EBBR compliant can be achieved by using a recent
> version of U-Boot with the appropriate configuration options. An
> implementers guide for U-Boot will be written before EBBR v1.0 is released.
> 
> There is also work ongoing to get the UEFI Self Certification Test
> running on U-Boot. Once working, this will be a tool for vendors to test
> their platforms for EBBR compliance.
> 
> FAQ
> ---
> 1. Does EBBR define a new interface?
> 
> ?? No. EBBR builds on the existing UEFI spec by requiring a specific
> subset that can be implemented today using U-Boot, and either Devicetree
> or ACPI.
> 
> 2. Does EBBR require Devicetree? ACPI?
> 
> ?? EBBR allows platforms to provide either ACPI or Devicetree. Linux
> supports both system description languages equally well, and Devicetree
> is in common use on embedded platforms. As long as the platform supplies
> a system description that can boot a mainline operating system.
> 
> ?? EBBR does not attempt to define a common base standard for Devicetree
> platforms because of the wide variety of platforms needed to be
> supported. The one assumption EBBR does make is that the target
> operating system already has support for the SoC on the platform.
> 
> 3. Is EBBR only for U-Boot and Linux embedded systems?
> 
> ?? No. While U-Boot+Linux platforms were certainly the primary audience
> when EBBR was first conceived, the spec is very purposefully written to
> be OS-independent. EBBR requires specific interfaces, but those
> interface can be implemented by any firmware project.
> 
> ?? We would absolutely like to have review, feedback and contributions
> from non-Linux, non-U-Boot users.
> 
> 4. Can I contribute to the EBBR specification?
> 
> ?? Yes. The EBBR source document is on GitHub, and we use the
> boot-architecture at lists.linaro.org mailing list.
> 
> ?? https://github.com/ARM-Software/ebbr
> _______________________________________________
> Arm.ebbr-discuss mailing list
> Arm.ebbr-discuss at arm.com
