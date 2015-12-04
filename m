From: asamson@codeaurora.org (Azriel Samson)
Date: Fri, 4 Dec 2015 14:53:38 -0700
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <CAB5YjtCCO3vB6hrktL9wmpSP6mmtHGd-TQhYK3GnS1eQ7-XU-w@mail.gmail.com>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org> <55653538.8020206@codeaurora.org>
 <2420285.dn5MbvMKXS@wuerfel> <55664FD9.1090808@codeaurora.org>
 <556BFAD1.7010907@redhat.com>
 <CAOZdJXXtMn2==b6y8Lf7Kvc4fWS6Zn_ZxwkO_1OhBPhL2PtfMg@mail.gmail.com>
 <fcf2a95bf9a7a9fce6ee864a747cea9a.squirrel@www.codeaurora.org>
 <CAB5YjtCCO3vB6hrktL9wmpSP6mmtHGd-TQhYK3GnS1eQ7-XU-w@mail.gmail.com>
Message-ID: <56620B62.5060800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 7/13/2015 3:03 AM, AKASHI, Takahiro wrote:
> Sorry for not replying soon.
>
> On 9 July 2015 at 08:03, Azriel Samson <asamson@codeaurora.org
> <mailto:asamson@codeaurora.org>> wrote:
>  >
>  > Hi,
>  >
>  > When booting the crash kernel with ACPI, how do you ensure that the ACPI
>  > tables fall within the kernel's memmap region?
>  > I was able to boot with ACPI when the crash kernel's memory overlapped
>  > with the ACPI tables(based on the "crashkernel" and "mem" boot
> arguments).
>
> I don't think this is a right way to use kdump in ACPI environment on arm64
> because "mem" parameter only limits the maximum size of usable memory
> and so the crash dump data (/proc/vmcore) can get easily corrupted if
> the reserved
> memory region that the crash dump kernel can use also contains any
> portion of
> memory which belong to the crashed kernel.
>
> In the current implementation of arm64 kdump, kexec command manages to
>   exclude such memory regions by modifying the device tree passed on to
> the crash dump kernel.
>
>  > Is there a better way to make the ACPI tables available to the crash
> kernel?
>
> So ACPI tables is not the only problem.
> x86 seems to use "memmap" kernel parameter instead.(?)

I was able to test kdump with the following patch from Mark Salter which 
is needed for supporting ACPI tables that lie outside of kernel RAM:
https://git.fedorahosted.org/cgit/kernel-arm64.git/commit/?h=devel&id=a75bcec5679a2ff82f23c5cc335c77da158a6dc5


>
> Thanks,
> -Takahiro AKASHI
>

-- 
Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
