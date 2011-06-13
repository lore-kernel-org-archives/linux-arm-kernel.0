From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Jun 2011 17:33:53 -0600
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110613220559.GH13643@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<201106121615.24059.arnd@arndb.de>
	<20110612143428.GI10283@n2100.arm.linux.org.uk>
	<201106121701.22418.arnd@arndb.de>
	<20110612153536.GL10283@n2100.arm.linux.org.uk>
	<it5rlq$3f0$1@dough.gmane.org>
	<20110613220559.GH13643@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimkH8t9cc8nk4EiXhD19NMDSqbddA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 4:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 13, 2011 at 08:24:27PM +0000, Dmitry Eremin-Solenikov wrote:
>> Russell King - ARM Linux wrote:
>>
>> > On Sun, Jun 12, 2011 at 05:01:22PM +0200, Arnd Bergmann wrote:
>> >> Of course it should override the device tree, I'm not arguing that.
>> >> All I'm saying is that we don't need to special-case this or support
>> >> both formats once the kernel is there as long as we move the information
>> >> into appropriate DT-representation of the same data.
>> >
>> > You're arguing for it to be parsed by whatever fragment of assembly code
>> > we have to place around the zImage to merge it into DT.
>> >
>> > And yes, it's going to have to be assembly code because we don't have a
>> > C environment at that point which can run in a relocatable way.
>>
>> Please, again look at the cuboot stuff which is used on powerpc. It uses
>> limited C environment: it's executed before kernel entry, so it can use
>> stack, etc. as setup by the bootloader.
>
> Boot loaders don't pass a stack to the kernel - what may be in the
> stack pointer may not be valid at the point when the kernel is called -
> it may be that it can only be used while the MMU is on, and at this
> point the MMU will be off. ?So you can't rely on anything from the
> boot loader which I haven't documented as being part of the ARM kernel
> boot protocol.
>
> Please understand that we absolutely must get this issue resolved before
> the next merge window, and have a solution ready to be merged at that
> point. ?As I see it, this is one of the major issues that requires
> addressing. ?Why?

John Bonesio is working on it this week (starting tomorrow), and will
get an updated patch out ASAP.

g.
