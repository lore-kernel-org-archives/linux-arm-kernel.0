From: james.morse@arm.com (James Morse)
Date: Tue, 07 Mar 2017 11:37:15 +0000
Subject: [PATCH V12 00/10] Add UEFI 2.6 and ACPI 6.1 updates for RAS on
 ARM64
In-Reply-To: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
References: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <58BE9B6B.3020000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 06/03/17 20:44, Tyler Baicar wrote:
> When a memory error, CPU error, PCIe error, or other type of hardware error
> that's covered by RAS occurs, firmware should populate the shared GHES memory
> location with the proper GHES structures to notify the OS of the error.
> For example, platforms that implement firmware first handling may implement
> separate GHES sources for corrected errors and uncorrected errors. If the
> error is an uncorrectable error, then the firmware will notify the OS
> immediately since the error needs to be handled ASAP. The OS will then be able
> to take the appropriate action needed such as offlining a page. If the error
> is a corrected error, then the firmware will not interrupt the OS immediately.
> Instead, the OS will see and report the error the next time it's GHES timer
> expires. The kernel will first parse the GHES structures and report the errors
> through the kernel logs and then notify the user space through RAS trace
> events. This allows user space applications such as RAS Daemon to see the
> errors and report them however the user desires. This patchset extends the
> kernel functionality for RAS errors based on updates in the UEFI 2.6 and
> ACPI 6.1 specifications.

This series doesn't apply cleanly to v4.11-rc1, what did you base it on?

Please base this on a v4.11 release candidate if you want it considered for v4.12.


Thanks,

James
