From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 12 Aug 2013 15:02:11 -0400
Subject: SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <52082EF8.10005@roeck-us.net>
References: <5207B3C3.9080508@roeck-us.net>
 <20130811220450.GY23006@n2100.arm.linux.org.uk> <52082EF8.10005@roeck-us.net>
Message-ID: <52093133.9050306@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-11 08:40 PM, Guenter Roeck wrote:
> On 08/11/2013 03:04 PM, Russell King - ARM Linux wrote:
>> On Sun, Aug 11, 2013 at 08:54:43AM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> trying to boot arm versatile images with qemu results in the following error
>>> if I try to boot with a disk image.
>>>
>>>       sym0: <895a> rev 0x0 at pci 0000:00:0d.0 irq 92
>>>       sym0: SCSI BUS has been reset.
>>>       scsi0 : sym-2.2.3
>>>       [...]
>>>       scsi 0:0:0:0: ABORT operation started
>>>       scsi 0:0:0:0: ABORT operation timed-out.
>>>       [...]
>>>
>>> Yocto's 3.8 kernel images work, upstream kernels 3.8 and later fail
>>> (I did not check if/how earlier kernels are affected).
>>>
>>> Tracking this down shows that the problem is known and has been fixed with
>>> commit 351d1339 (arm: add dummy swizzle for versatile with qemu) in the
>>> Yocto 3.8 kernel at git://git.yoctoproject.org/linux-yocto-3.8.
>>>
>>> Would it be possible to submit this patch for inclusion into affected upstream kernels ?
>>
>> It could be that it's qemu's PCI routing is wrong - it's not the first
>> time that qemu has got something wrong.
>>
>> Unfortunately, the PCI routing is totally undocumented, and as I understand
>> it, there's very few backplanes out there now that finding out their real
>> routing is virtually impossible.  I'm loathed to change it unless someone
>> can point to a definitive source of information on this.
>>
> 
> Maybe Paul can comment, as he wrote the patch.

If I recall correctly, I'd showed the patch to Russell at the time (via
IRC, I believe) and he'd told me essentially the same thing as the above
paragraph, which is why I didn't put it in the patch system, and why the
commit log of the yocto patch (http://goo.gl/riEZXY) reads as it does
(i.e. it is unclear what the real swizzle is).  If docs appear that help
clarify where the real issue is, then great.

Paul.
--

> 
> If it helps, I tried with qemu 1.4.0 from Ubuntu 13.4, qemu 1.4.0 from Poky 1.4.0-1,
> and qemu 1.5.2 from the qemu repository.
> 
> Copying qemu-devel to increase the audience.
> 
> Guenter
> 
