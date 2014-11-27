From: dyoung@redhat.com (Dave Young)
Date: Thu, 27 Nov 2014 14:22:14 +0800
Subject: [PATCH v3 03/13] arm64: improve CONFIG_STRICT_DEVMEM handling
In-Reply-To: <CAKv+Gu8UyfdFhaKXNQMzuf7L3b9jDyUd4FzG1x-c7FfoxnZe=Q@mail.gmail.com>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416315432-8534-4-git-send-email-ard.biesheuvel@linaro.org>
 <20141126093042.GA6474@darkstar.nay.redhat.com>
 <CAKv+Gu8UyfdFhaKXNQMzuf7L3b9jDyUd4FzG1x-c7FfoxnZe=Q@mail.gmail.com>
Message-ID: <20141127062214.GC2860@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/14 at 05:23pm, Ard Biesheuvel wrote:
> On 26 November 2014 at 10:30, Dave Young <dyoung@redhat.com> wrote:
> > On 11/18/14 at 01:57pm, Ard Biesheuvel wrote:
> >> Improve the handling of /dev/mem mappings under CONFIG_STRICT_DEVMEM by:
> >> - allowing read-only access to parts of System RAM that are not
> >>   considered memory by the kernel, this is mainly intended for exposing
> >>   UEFI Configuration tables to userland;
> >
> > Ard, can you elabrate a bit? Are this for the acpi case because no dtb in
> > procfs?
> >
> 
> No, that is a different issue.
> 
> > Anyway I also think using /dev/mem looks not a good way to expose
> > infomation to userspace.
> >
> 
> This is for compatibility with existing tools like dmidecode and lshw
> that already use /dev/mem.
> However, on x86, the tables they access are in iomem resource ranges
> that are accessible under CONFIG_STRICT_DEVMEM, whereas on arm64,
> those regions are inaccessible.
> 
> So while our position is that using /dev/mem for *anything* is an
> awful idea, this particular patch just tries to bring arm64 in line
> with what currently existing tools expect.

Ard, Ok, thanks for the clarification.
