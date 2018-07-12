From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Jul 2018 15:22:12 -0700
Subject: [RFC PATCH 0/2] efi: add contents of LinuxExtraArgs EFI var to
 command line
In-Reply-To: <20180704154919.18564-1-ard.biesheuvel@linaro.org>
References: <20180704154919.18564-1-ard.biesheuvel@linaro.org>
Message-ID: <4bd9bee6-f2b9-3197-c205-fec104fd1090@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 07/04/2018 08:49 AM, Ard Biesheuvel wrote:
>   efi/libstub: taken contents of LinuxExtraArgs UEFI variable into
>     account

To me this seems an overly complicated interface to the kernel, and
still doesn't in itself solve the problem at hand -- make the
generic distro kernel with APEI support run on m400 systems.

As for me, I'd prefer something like my original patch.  It fixes
that problem, it is simple and self contained, and is very clear
in what it does.  Also, there is a limited life.  When the time
comes an announcement is made to the mailing lists 'Linux-XYZ will
no longer support the m400 Moonshot'.  Then, when the Linux-XYZ-rc1
merge window opens a patch goes in that removes the
acpi_fixup_m400_quirks() routine.

-Geoff
