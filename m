From: narkewoody@gmail.com (Woody Wu)
Date: Mon, 10 Dec 2012 06:25:38 +0000 (UTC)
Subject: Serial8250 doesn't populate in /proc/iomem?
Message-ID: <slrnkcb014.77o.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, list

I found some io memory information is lost from /dev/iomem and want to
find out why.

I have a 2.6.16 kernel running on a ARM board (Samsung S3C2410). From
the kernel log, I see 16 8250 serial ports were detected, and each of
thoese ports has a memory address:

Serial: 8250/16550 driver $Revision: 1.90 $ 16 ports, IRQ sharing enabled
serial8250: tts0 at MMIO 0xe1400000 (irq = 16) is a 16550A
serial8250: tts1 at MMIO 0xe1400008 (irq = 16) is a 16550A
serial8250: tts2 at MMIO 0xe1400010 (irq = 17) is a 16550A
serial8250: tts3 at MMIO 0xe1400018 (irq = 17) is a 16550A
serial8250: tts4 at MMIO 0xe1400020 (irq = 18) is a 16550A
serial8250: tts5 at MMIO 0xe1400028 (irq = 18) is a 16550A
serial8250: tts6 at MMIO 0xe1400030 (irq = 19) is a 16550A
serial8250: tts7 at MMIO 0xe1400038 (irq = 19) is a 16550A
serial8250: tts8 at MMIO 0xe1400040 (irq = 48) is a 16550A
serial8250: tts9 at MMIO 0xe1400048 (irq = 48) is a 16550A
serial8250: tts10 at MMIO 0xe1400050 (irq = 49) is a 16550A
serial8250: tts11 at MMIO 0xe1400058 (irq = 49) is a 16550A
serial8250: tts12 at MMIO 0xe1400060 (irq = 60) is a 16550A
serial8250: tts13 at MMIO 0xe1400068 (irq = 60) is a 16550A
serial8250: tts14 at MMIO 0xe1400070 (irq = 61) is a 16550A
serial8250: tts15 at MMIO 0xe1400078 (irq = 61) is a 16550A

I can read/write these serial ports from /dev/ttys*, in other words,
they do exist.  I also can find the driver info from /proc/devices:

Character devices:                                               

  ...
  4 /dev/vc/0
  4 tty
  4 tts
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
  ...

The problem is, I don't understand why there is no information about
these ports in /proc/iomem file. The 'iomem' file now contains:

11000000-11000ffe : AX88796B
19000000-19000ffe : AX88796B
30000000-33ffffff : System RAM
  3001c000-301e826b : Kernel text
  301ea000-302234a3 : Kernel data

-- 
woody
I can't go back to yesterday - because I was a different person then.
