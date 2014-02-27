From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 27 Feb 2014 17:34:33 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226151536.58154704@anubis.ausil.us>
References: <20140226183454.GA14639@cbox>
 <20140226134251.0436294e@anubis.ausil.us>
 <CAMJs5B9bCs8Oz2Zg4UK--A3H4AaZRPMwy7SpxYom-1--_=qhBQ@mail.gmail.com>
 <20140226151536.58154704@anubis.ausil.us>
Message-ID: <CACxGe6sQd7VFQtjoNsAtYB=-87ZTOZ73B_s7QFcggSdm39U-mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 9:15 PM, Dennis Gilmore <dennis@gilmore.net.au> wrote:
> On Wed, 26 Feb 2014 11:56:53 -0800
> Christoffer Dall <christoffer.dall@linaro.org> wrote:
>
>> [why did you drop everyone from cc here?]
>
> standard reply to list behavior, I would appreciate if you followed it.

Not on the Linaro, infradead or vger lists. We preserve cc's here, always have.

>> On 26 February 2014 11:42, Dennis Gilmore <dennis@gilmore.net.au>
>> wrote:
>> > On Wed, 26 Feb 2014 10:34:54 -0800
>> > Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> Also, I'm afraid "u-boot and look like an existing 32 bit system" is
>> not much of a spec. How does a distro vendor ship an image based on
>> that description that they can be sure will boot?
>
> based on the work to make a standard boot environment I have been
> working on, pass in the u-boot binary and things will work by loading
> config from inside the image and acting just like any system. really
> UEFI is major overkill here and a massive divergence from the real
> world. What is the argument that justifies the divergence?

That's what I used to say all the time until I actually looked at it.
It isn't the horrid monster that many of us feared it would be. There
is a fully open source implementation hosted on sourceforge which is
what I would expect most VM vendors to use directly. It isn't
unreasonably large and it implements sane behaviour.

Remember, we are talking about what is needed to make a portable VM
ecosystem. The folks working on the UEFI spec have spent a lot of time
thinking about how to choose what image to boot from a disk and the
spec is well defined in this regard. That aspect has not been U-Boot's
focus and U-Boot isn't anywhere near as mature as UEFI in that regard
(nor would I expect it to be; embedded has never had the same
incentive to create portable boot images as general purpose machines).

Also, specifying UEFI for this spec does not in any way prevent
someone from running U-Boot in their VM, or executing the kernel
directly. This spec is about a platform for portable images and it is
important to as much as possible specify things like firmware
interfaces without a whole lot of options. Other use-cases can freely
disregard the spec and run whatever they want.

>> Personally I think keeping things uniform across both 32-bit and
>> 64-bit is better, and the GTP/EFI image is a modern standard that
>> should work well.
>
> It means that installers will need special code paths to support being
> installed into virt guests and is not sustainable or supportable. as
> hardware wont work the same way.

Installers already have the EFI code paths, the kernel patches for
both 32 and 64 bit ARM are in-flight and will get merged soon. The
grub patches are done and merged. Installers will work exactly the
same way on real hardware with EFI and on VMs with EFI. It will also
work exactly the same way between x86, ARM and ARM64. What part is
unsustainable?

g.
