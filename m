From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 15 Jan 2014 20:54:45 +0100
Subject: v3.12 regression from "ARM: kirkwood: convert to DT irqchip and
 clocksource" on non-DT kirkwood platforms
In-Reply-To: <1389777972.12434.115.camel@kazak.uk.xensource.com>
References: <1389775235.10695.51.camel@dagon.hellion.org.uk>
 <52D651CD.5020307@gmail.com>
 <1389777972.12434.115.camel@kazak.uk.xensource.com>
Message-ID: <52D6E785.4000706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2014 10:26 AM, Ian Campbell wrote:
> On Wed, 2014-01-15 at 10:15 +0100, Sebastian Hesselbarth wrote:
>> On 01/15/14 09:40, Ian Campbell wrote:
>>> The bootlogs are below or in the bug. It stops after "Console: colour
>>> dummy device 80x30", I think next would normally be the
>>> BogoMIPS/calibrate_delay output.
>>
>> That would indicate the timer (clocksource) or irq (irqchip) is not
>> running correctly. Again, that could be non-DT and DT fighting for it.
>> I'll investigate that.
>
> That seems logical.
>
>> In the meantime, can you recompile your kernel and set
>> CONFIG_ARCH_KIRKWOOD_DT=n ?
>
> I can confirm that v3.13-rc8 with CONFIG_ARCH_KIRKWOOD_DT=n works.
>


Ian,

please try the following two patches on top of v3.13-rc8 and report
back, if it solves the regression.

I have tested this on a revived non-DT Kirkwood Dockstar with and
without DT support enabled. I also compile tested it for Orion5x
and Dove.

While I will not send any patches for non-DT mach-dove boards as
none of them is really used anymore, Gregory is on Cc for hopefully
testing orion5x.

For possible -stable patches, I know it is quite a huge patch but
I didn't dare to touch arch/arm/kernel/foo for this kind of regression.

Sebastian

(I hope the fscking Thunderbird inlines both patches correctly)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-orion-provide-C-style-interrupt-handler-for-MULT.patch
Type: text/x-patch
Size: 2724 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/2abdebf2/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-kirkwood-set-C-style-handle_irq-if-MULTI_IRQ_HAN.patch
Type: text/x-patch
Size: 8378 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/2abdebf2/attachment-0001.bin>
