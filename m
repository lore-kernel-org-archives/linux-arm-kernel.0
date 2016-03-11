From: agraf@suse.de (Alexander Graf)
Date: Fri, 11 Mar 2016 18:52:54 +0100
Subject: [PATCH 0/8] EFI framebuffer support for ARM and arm64
In-Reply-To: <CAKv+Gu8imCVQ+8QM+txqXNgs54p2Uv3FMkQEMNoCkB8JJcaZUw@mail.gmail.com>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <56E19CD1.6080409@redhat.com>
 <CAKv+Gu8imCVQ+8QM+txqXNgs54p2Uv3FMkQEMNoCkB8JJcaZUw@mail.gmail.com>
Message-ID: <56E305F6.5070402@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.03.16 17:23, Ard Biesheuvel wrote:
> (+ Laszlo)
> 
> On 10 March 2016 at 23:12, Mark Langsdorf <mlangsdo@redhat.com> wrote:
>> On 03/09/2016 11:40 PM, Ard Biesheuvel wrote:
>>>
>>> This series adds support to ARM and arm64 for using the kernel's EFI
>>> framebuffer driver to drive EFI Graphics Output Protocol (GOP) based
>>> framebuffers.
>>>
>>> This involves refactoring some of the existing x86 code so it can be
>>> reused
>>> by ARM and arm64, and wiring it up both in the UEFI stub and in the core
>>> kernel into the existing UEFI infrastructure for ARM and arm64.
>>
>>
>> Given that I have access to a variety of different ARM64 UEFI
>> implementations, how would I go about testing this code? Do I
>> need a specific UEFI implementation and are there any special
>> command line arguments I should pass to the kernel?
>>
> 
> I have tested this myself on QEMU and FVP Base, which are both
> software models. On bare metal, it would involve a system with a
> graphics card that the firmware knows how to drive, and I am honestly
> not sure if any such combinations currently exist, other than the ARM
> development platforms such as Juno which have an embedded-style (i.e.,
> non-PCI) graphics controller that the firmware knows how to drive out
> of the box.
> 
> The code itself is smart enough to figure which (if any) of the
> available handles carrying the GOP protocol is the one that is
> attached to ConOut, and so there is nothing required to enable this
> other than building it into the kernel and running it on a system with
> a firmware supported screen attached.
> 

How does this deal with caches? Does the GOP driver access the frame
buffer as cached or as uncached memory? I suppose it's always uncached?

I'm mostly curious because I'd like to implement support for GOP in
U-Boot soon.


Alex
