From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Oct 2011 15:27:13 -0700
Subject: [PATCH v2 01/14] ARM: tegra: annotate IO_*_VIRT pointers
In-Reply-To: <20111013141036.GX21648@n2100.arm.linux.org.uk>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
	<1318224484-2090-2-git-send-email-olof@lixom.net>
	<20111013141036.GX21648@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMghHKR5Z3LxH454_OgaeiD+1KN4tFYgPqChbY7h4LsGZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 7:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 09, 2011 at 10:27:51PM -0700, Olof Johansson wrote:
>> +#ifdef __ASSEMBLY__
>> +#define __IOVADDR(x) (x)
>> +#else
>> +#define __IOVADDR(x) ((void __force __iomem *)(x))
>
> Please call this IOMEM() - see:
>
> grep '#define *IOMEM' arch/arm/*/include/mach -r
>
> for its establishment across several implementations.


Ah, thanks! I did look for a pre-existing one, but not closely enough.
I've revised the patch and will send a fresh pull request to Arnd with
the new contents.

I suppose there is some value in doing a global variant of this
instead of having it redefined on all platforms. I'll add it to the
list of cleanups to look at.


-Olof
