From: dashie@sigpipe.me (Dashie)
Date: Thu, 20 Feb 2014 22:22:35 +0100
Subject: Stuck getting DTS working for a new kirkwood board
Message-ID: <5306721B.7020403@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm a very beginner in the DTS and ARM kernel world and trying to get a
DTS working for my new toy.

I've done some tests using mainlineLinux and arcNumber and i remember to
got some things working (PCI-e, Intel eth) but only two drives and no
fan/sensor using arcNumber for "00000b1e    HP t5325 Thin Client       
                        2846".

I've since started to use a DTS, copied the guruplug-server-plus (IIRC)
and done some changes, actually i can get working :
    - temp sensor
    - fan control (off, middle, full)
    - integrated marvell eth
    - the four disks are detected and seems working

But can't get the PCI-e working (and then the intel ethernet), also
sensor path seems to change every reboot (i need to do more tests).
Also i've SATA power reg enabled in the DTS but it doesn't seems to have
any (to be confirmed, the original firmware seems to have the ability to
shutdown unaccessed drives) and i will remove them, anyway i don't know
the GPIO, if any.

I still miss some GPIOS for : Led (r/g) power, func led, the four sata
leds, maybe some triggers for hdds, and the power and func buttons.
(already tried gpio export and out direction and "1" in value, but
nothing blink)
Reset button sends things in /dev/input/input0 so it seems to works.

The current DTS is joined to this mail, i've actually the NAS with me
and can test things. I can provide too : original dmesg (from original
firmware), current dmesg using DTS, lspci -vvv (from kernel with arcNumber).

I'm currently using a stock 3.12.9 debian kernel and doesn't have
anymore access to the original firmware.

Regards,
Dashie.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kirkwood-verbatim-powerbay.dts
Type: audio/vnd.dts
Size: 5323 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/e2cc16f6/attachment-0001.dts>
