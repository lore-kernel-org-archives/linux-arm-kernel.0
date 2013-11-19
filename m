From: bgamari.foss@gmail.com (Ben Gamari)
Date: Tue, 19 Nov 2013 09:37:22 -0500
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
In-Reply-To: <528AE58B.5030209@ti.com>
References: <87hab9agjr.fsf@gmail.com> <528AE58B.5030209@ti.com>
Message-ID: <87mwl0o3tp.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lokesh Vutla <lokeshvutla@ti.com> writes:

> Hi Ben,
> On Monday 18 November 2013 08:44 PM, Ben Gamari wrote:
>> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
>> linux-next (30121118). I'm booting with a brand new u-boot
>> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
>> 
>> In both cases the device appears to hang shortly before one would expect
>> init to start as seen in the boot output below. I'm booting with the
>> omap4-panda-es devicetree. As far as I can tell, the machine is
>> completely dead and will not respond to even sysrq. I have a PandaBoard
>> A4 which apparently has no trouble with the same kernel image.
> 
> Which defconfig are you using ?
>
I derived the config from RobertCNelson's Debian Wheezy image. It did
require some modification, however.

> Can you see if CPU_IDLE is enabled in your defconfig?
>
Yes, CPU_IDLE is enabled.

> I saw a similar failure on my panda es when CPU_IDLE is enabled.
> If this is the case for you please apply this[1] patch and give a try.
>

Indeed that did the trick. Thanks for the reference!

I do however now see periodic messages of the form,

    [   42.143005] gic_timer_retrigger: lost localtimer interrupt

Any idea what this might be due to?

Cheers,

- Ben

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/b18d28cb/attachment.sig>
