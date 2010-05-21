From: jcrigby@gmail.com (John Rigby)
Date: Fri, 21 May 2010 10:24:27 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005191614580.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
	<alpine.LFD.2.00.1005191055180.12758@xanadu.home>
	<20100519200819.GF1693@shareable.org>
	<alpine.LFD.2.00.1005191614580.12758@xanadu.home>
Message-ID: <AANLkTil3vDAN4QIJJImk8MnQklisqFJq_RBc7c9VEZxl@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wow, no responses for almost two days, does that mean consensus has
been reached?

On Wed, May 19, 2010 at 2:22 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 19 May 2010, Jamie Lokier wrote:
>
>> Nicolas Pitre wrote:
>> > It is not up to the bootloader to "adjust" to the kernel. ?But rather
>> > for the kernel to cope with the bootloader's provided information. ?If
>> > the bootloader passes a specific machine ID with the ATAG list then the
>> > kernel will use that, and if the bootloader passes a DT machine ID with
>> > a DT blob then the kernel will use that. ?You just have to configure
>> > your kernel with both "machine types" at the same time.
>>
>> Scenario:
>>
>> You upgrade your systems to a new DT-capable kernel and DT-capable
>> bootloader. ?It works great. ?You ship new instances of your device with this.
>>
>> Once they're in the field, someone reports a bug that doesn't happen
>> with the older device instances. ?It's not a bug you can reproduce,
>> but you suspect the newer of kernel. ?So you remote-update some of the
>> newly shipped devices with an old, pre-DT kernel binary that's been
>> stable on the older devices, to see if the bug goes away.
>>
>> Problem: The newer shipped devices have a DT-capable bootloader, and
>> it can't boot old kernels, because they don't understand the DT format.
>>
>> You could remote-downgrade the bootloaders, but that's risky. ?You
>> could try building the old kernel with DT support, but that adds
>> another variable to your testing.
>>
>> Anticipating this well in advance, you of course built your DT-capable
>> bootloader with the ability to boot old and new style kernels...
>
> Exact. ?Quoting myself:
>
> |I think that, for the moment, it is best if the bootloader on already
> |existing subarchitectures where DT is introduced still preserve the
> |already existing ability to boot using ATAGs. ?This allows for the
> |testing and validation of the DT concept against the legacy ATAG method
> |more easily.
> |
> |On new subarchitectures, it might make sense to go with DT from the
> |start instead of creating setup code for every single machine. ?In that
> |case the bootloader for those machines would only need to care about DT
> |and forget about ATAGs.
>
>
> Nicolas
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
