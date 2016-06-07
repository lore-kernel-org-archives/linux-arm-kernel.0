From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Tue, 7 Jun 2016 19:53:53 +0900
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <20160607102317.GC2633@leverpostej>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
 <20160607102317.GC2633@leverpostej>
Message-ID: <7faf36bf-00d9-fb37-381a-6324d1dba977@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark

On 6/7/16 7:23 PM, Mark Rutland wrote:
> On Tue, Jun 07, 2016 at 05:06:39PM +0900, Itaru Kitayama wrote:
>> Upstream v4.7-rc2 kernel does not boot if parameter acpi is set to force
>> on Overdrive. (acpi=off gets to the prompt)
>
> Did acpi=force work on this board with an earlier kernel (e.g. v4.6)?

v4.6 boots fine with acpi=foce.

>
>> When set to force it doesn't get to the Linux boot process and stalls.
>
> What output do you get before it stalls?
>
> I assume that you at least have output from the EFI stub?

Yes.
>
> Which command line options are you passing?

At the time of trying, only acpi=foce efi=debug

>
> If you get nothing after the stub, try also passing:
>
> earlycon=pl011,0xe1010000

Adding it in the /etc/default/grub file and updating grub via
mkgrub2-config seems to made the board always falls on the grub prompt.
I am able to switch to the EFI shell, but is there an easy way to 
recover it? (I'm accessing the board remotely)

>
> Which may give an indication of what's going on.
>
>> Here's the BIOS info:
>>
>> Version 2.17.1249. Copyright (C) 2015 American Megatrends, Inc.
>> BIOS Date: 09/03/2015 13:52:32 Ver: ROD0084E00
>
> I don't know if the FW from a year ago provided everything necessary. It
> may be something like the SPCR is simply missing, and there's no
> console= passed to the kernel.
>
> Thanks,
> Mark.
>
