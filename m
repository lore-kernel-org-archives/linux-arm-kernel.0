From: andre.przywara@linaro.org (Andre Przywara)
Date: Fri, 06 Sep 2013 15:30:47 +0200
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <CAL_JsqKfcudKiTOr-MrHsq6NidG-5t5S0t08ELTSpOuc2LF4RQ@mail.gmail.com>
References: <52260608.2030202@linaro.org>
 <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
 <5226F2B3.10606@linaro.org>
 <CAL_JsqKfcudKiTOr-MrHsq6NidG-5t5S0t08ELTSpOuc2LF4RQ@mail.gmail.com>
Message-ID: <5229D907.7060902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2013 03:23 PM, Rob Herring wrote:
> On Wed, Sep 4, 2013 at 3:43 AM, Andre Przywara
> <andre.przywara@linaro.org> wrote:
>> On 09/04/2013 12:00 AM, Rob Herring wrote:
>>>
>>> On Tue, Sep 3, 2013 at 10:53 AM, Andre Przywara
>
>>> But surely there would be some advantage of reuse by using the
>>> multi-boot protocol since Xen, grub, and OS tools already support it
>>> for x86.
>>
>>
>> Yes, but that is x86 only and multiboot is it's nature quite architecture
>> specific. The current(?) multiboot v2 spec has no official ARM support (only
>> x86 and MIPS), so this would need to be "invented" first. While this is
>> technically easy, ARM software currently has no support for multiboot at
>> all: not in u-boot and not in Xen.
>> Multiboot support in Xen lives entirely in the x86 directory, and big parts
>> of it are even in assembly.
>
> If so, I cannot find the assembly and most of it seems to be moved out
> of x86 code now.

There is some code that relocates and maps the multiboot structure: in 
files in the xen/arch/x86/boot directory, including head.S, reloc.c and 
setup.c.
That would need to be completely rewritten, not only because it deals 
with multiboot v1, but also because it is scattered throughout the x86 
setup code and the initial page setup is different from ARM.

All these things are also done on ARM - but for the device tree already.
Of course proper multiboot v2 support is doable - but please compare the 
effort needed for this against this one:
http://lists.xen.org/archives/html/xen-devel/2013-09/msg00359.html

Regards,
Andre.
