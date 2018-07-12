From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2018 17:49:19 +0100
Subject: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
In-Reply-To: <20180709234229.20181-1-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
Message-ID: <20180712164918.GA26935@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> This patch series is a set of bug fixes to address kexec/kdump
> failures which are sometimes observed on ACPI-only system and reported
> in LAK-ML before.

I tried picking this up, along with Ard's fixup, but I'm seeing a build
failure for allmodconfig:

arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'

I didn't investigate further. Please can you fix this?

Will
