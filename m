From: graeme.gregory@linaro.org (G Gregory)
Date: Sun, 13 Dec 2015 16:54:44 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <20151207060546.GA27677@svinekod>
References: <566D3090.9090509@redhat.com>
	<20151207060546.GA27677@svinekod>
Message-ID: <CAGCh1+kB5a0k36t+nyEz-=Rt+p0+AaT8jZGqphc4wuK49+y7VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 December 2015 at 06:05, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Sun, Dec 13, 2015 at 03:47:12AM -0500, Jon Masters wrote:
>> Hi Folks,
>>
>> Just a few notes that might be useful to someone else.
>>
>> I mentioned before that we'll want to see ACPI_INITRD_TABLE_OVERRIDE
>> support on arm64 in due course for use during bringup of new systems. It
>> is commonly used on x86 to provide handy updated ACPI tables via a
>> prepended initrd cpio that is attached to the regular initrd image,
>> which is infinitely better than respinning firmware each time you want
>> to provide updated tables (yes yes, we all know the "devicetree"
>> directive in GRUB does this with DT and that's great and wonderful). I
>> know that someone is working on it, but I had a need for an interim
>> solution over the weekend for some hardware I am bringing up here.
>
> Which table(s) are you trying to override?
>
> It might be possible to have an EFI application prior to the kernel which
> override the relevant table, or you may be able to override the tables in the
> EFI stub. From the PoV of Linux proper, things would then be the same as a
> normal boot -- nothing special to be done.
>
> If you're able to do this in a separate application prior to the stub (or even
> prior to the main bootloader), that same override should work for any OS.
>

grub2 already has a acpi module which should allow this.

Graeme
