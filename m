From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Aug 2015 13:21:04 +0200
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <20150825104422.GO7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
 <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
 <20150825104422.GO7557@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdWCLcDS=64m0J09KJJ4bDtgZ1Yvq8rw7u9FE0vZkKT2cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Aug 25, 2015 at 12:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 25, 2015 at 12:32:51PM +0200, Geert Uytterhoeven wrote:
>> This patch, which is now in arm-soc/for-next, breaks shmobile_defconfig
>> on r8a7791/koelsch, which has a dual core CA15:
>>
>>     [ ok ] Configuring network interfaces...done.
>>     Unhandled fault: page domain fault (0x01b) at 0xbe8e6120
>>     pgd = edbb0000
>>     [be8e6120] *pgd=6da77831, *pte=bf4d075f, *ppte=bf4d0c7f
>>     Internal error: : 1b [#1] SMP ARM
>>     CPU: 1 PID: 1629 Comm: ntpdate Not tainted
>> 4.2.0-rc8-06444-g3c24fd89c9421db1 #31
>>     9
>>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>>     task: ed883a80 ti: ed41c000 task.ti: ed41c000
>>     PC is at csum_partial_copy_from_user+0x28/0x3d8
>>     LR is at csum_and_copy_from_iter+0x334/0x4c0
>>     pc : [<c04ba510>]    lr : [<c01c82e8>]    psr: 000f0013
>>     sp : ed41db00  ip : 00000020  fp : ed41db6c
>>     r10: ed41ddc0  r9 : 00000027  r8 : ed41dc20
>>     r7 : 00000027  r6 : eda52653  r5 : ed41dec8  r4 : 00000000
>>     r3 : 00000000  r2 : 00000027  r1 : eda5262c  r0 : be8e6120
>>     Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>     Control: 10c5307d  Table: 6dbb006a  DAC: 00000051
>>     Process ntpdate (pid: 1629, stack limit = 0xed41c210)
>
> Thanks.  I wonder what's different about your ntpdate that triggers
> this, and why all my iMX6 behave fine, which have desktop-like ubuntu
> installs on (of two different versions.)

It's ntpdate 1:4.2.6.p5+dfsg-7 from desktop-like Debian jessie.

But I get similar dumps during boot up from rpc.idmapd (SyS_send),
rsyslogd (SyS_send), and from sshd (SyS_write) when trying to log in.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
