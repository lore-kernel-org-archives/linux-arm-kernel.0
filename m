From: agraf@suse.de (Alexander Graf)
Date: Sun, 27 Jan 2013 17:23:09 +0100
Subject: [kvmarm] [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual
 desktop
In-Reply-To: <87wquysor6.fsf@codemonkey.ws>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
 <87wquysor6.fsf@codemonkey.ws>
Message-ID: <153CCD6C-C1F5-4BF5-985B-8FEA38B3397E@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27.01.2013, at 15:07, Anthony Liguori wrote:

> Anup Patel <anup.patel@linaro.org> writes:
> 
>> Hi All,
>> 
>> How about having a generic Virtio-based machine for emulating a virtual
>> desktop ?
>> 
>> I know folks have already thought about this and probably also tried
>> something or other on this front but, it will be good to know the downsides.
>> 
>> Virtio-desktop can be a separate specification describing a virtual
>> desktop.
>> Of-course we cannot avoid few architecture dependent virtual devices in but
>> the Virtio-desktop specification will try to keep minimum possible
>> architecture dependent devices.
> 
> There's a lot of reasons why a pure PV machine type is a bad idea.  Lots
> of people have enumerated them in this thread.
> 
> But let me mention some things that I think we don't have covered today
> with PV:
> 
> - Graphics.  Yes, I know QXL exists but it's (a) dependent on PCI (b)
>   lacks the ability to gracefully degrade making it hopelessly tied to
>   spice.

There was a QXL-on-virtio port in the works a while ago IIRC:

> - Input.  PS/2 mouse provides relative input which sucks in guests.
>   For absolute input, we have VMMouse which is x86-specific, USB
>   tablets (which are expensive to emulate) or the spice mouse which is
>   intimately tied to the full Spice stack.

I thought the USB tablet is ok today thanks to auto-suspend of the bus? Or was that only with ehci?

> 
> - Guest interaction.  Copy/paste, drag and drop, etc.  In theory this
>   is covered in spice agents but it's all again hopelessly tied to
>   Spice which makes it non-portable.

- Keyboard. When running with VNC, the 3 stacks involved in converting keyboard layouts back and forth are really confusing to users.

> So there's good work todo but it's almost certainly in working with the
> Spice community to try to make what they already have more accessible to
> non-x86 architectures.

Hooray :)


Alex
