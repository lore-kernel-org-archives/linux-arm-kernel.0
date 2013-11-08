From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 08 Nov 2013 10:29:46 +0100
Subject: [patch 1/1] ARM: kirkwood: stop printk TCLK value at boot for DT
 boards
In-Reply-To: <527CA812.9050003@gmail.com> (Sebastian Hesselbarth's message of
 "Fri, 08 Nov 2013 10:00:02 +0100")
References: <20131105180931.674625171@rtp-net.org> <527CA812.9050003@gmail.com>
Message-ID: <87vc03s0l1.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

> On 11/05/2013 07:09 PM, Arnaud Patard (Rtp) wrote:
>> Commit 2326f04321a9 (ARM: kirkwood: convert to DT irqchip and clocksource)
>> dropped the call to kirkwood_timer_init() when booting with DT.
>> This results in kirkwood_tclk not being set and the boot message is now:
>>
>> Kirkwood: MV88F6281-A0, TCLK=0
>>
>> This patch modifies the message for printing only the kirkwood id,
>> as it allows to detect if we're running A0/A1/... variants with a simple
>> dmesg.
>
> Arnaud,
>
> for DT based booting we also have the "Machine" printed right above the
> "Kirkwood" string. Don't you think, that we can remove the pr_info
> completely?

The Machine give some valuable information as one can load wrong dtb
(already happened here). Moreover, it's a of thing (see
of_flat_dt_match_machine) so not something that can be decided on
kirkwookd side.
About possible redundancy of informations between the "Kirkwood:" and
the "Machine" lines, the former one gives the stepping. This allows to
know easily if kwboot has a chance to work on the serial port.

Arnaud
