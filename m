From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Apr 2016 13:40:54 +0100
Subject: [PATCH v9 00/14] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1461775633-29715-1-git-send-email-james.morse@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
Message-ID: <20160428124054.GC30834@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 05:46:59PM +0100, James Morse wrote:
> Hi all,

Hi James,

> This is the today's version of hibernate for arm64, based on arm64's
> for-next/core with latest commit 6a1f54711447 ("arm64: acpi: add acpi=on
> cmdline option to prefer ACPI boot over DT").

I've queued this locally, but it breaks an allmodconfig build:

kernel/built-in.o: In function `saveable_page':
memremap.c:(.text+0x100f90): undefined reference to `kernel_page_present'
kernel/built-in.o: In function `swsusp_save':
memremap.c:(.text+0x1026f0): undefined reference to `kernel_page_present'
make: *** [vmlinux] Error 1

Can you take a look, please?

Will
