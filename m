From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Nov 2014 19:46:34 +0000
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141031075209.GH3290@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
Message-ID: <20141103194634.GA30366@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 07:52:09AM +0000, Dave Young wrote:
> Hi Geoff
> 
> I tested your patches. The macihne is using spin-table cpu enable method
> so I tried maxcpus=1 as you suggested.
> 
> There's below issues for me, thoughts?
> 
> 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> to use.

Are you absolutely certain of this?

To use ACPI, you must have booted via EFI, as the only mechanism for
finding the ACPI tables is via EFI. If booted via EFI, the stub will
have created a stub DTB if there is no provided DTB, to pass the command
line and pointers to EFI data structures. This stub DTB should be
present in the usual place.

Thanks,
Mark.
