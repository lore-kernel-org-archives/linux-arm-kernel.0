From: eric@anholt.net (Eric Anholt)
Date: Fri, 24 Apr 2015 11:41:38 -0700
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <5539C5A4.5070409@wwwdotorg.org>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5539C5A4.5070409@wwwdotorg.org>
Message-ID: <87pp6tweql.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 04/21/2015 12:09 PM, Eric Anholt wrote:
>> This is my first submission of a Raspberry Pi 2 port.  It can be found
>> at https://github.com/anholt/linux/tree/bcm2836
>> 
>> I'm using the 2835 interrupt controller support, without adding the
>> checks for ARM local interrupts first.  That means no support for IPIs
>> (and thus no SMP), no PMU events, and no local timer (I'm using the
>> same 2835 peripheral one).
>> 
>> It supports a similar featureset to Pi 1 at this point.  Serial and SD
>> cards work.  Just one CPU supported.  USB (ethernet) works if you use
>> U-Boot, or my mailbox series
>> (https://github.com/anholt/linux/tree/bcm2836-mbox).
>
> I can't quite get this to work. I think what's happening is that U-Boot
> is over-writing the location of the code/data that the CPU1..3 pin loop
> uses. Do you know what that address is so I can confirm that?
>
> I suspect this because when I load the kernel/DT in U-Boot, or when I
> jump to the kernel to boot it, I see lots of extra duplicated characters
> on the UART, like all 4 CPUs are booting Linux. For example:

Oops, I was just extrapolating that U-Boot would work.  I've quit using
it because of the extra configuration work (particularly the compiled
text files for the boot scripts).

I haven't looked into how SMP works, because I don't have the interrupt
support necessary yet (bcm2836-irq branch for hacks in that direction).

And in further testing, the USB is actually not working and I'm not sure
what gave me the idea that it was.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150424/00df303a/attachment.sig>
