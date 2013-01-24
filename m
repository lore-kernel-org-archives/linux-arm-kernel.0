From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 24 Jan 2013 09:12:19 +0100
Subject: OHCI on Samsung S3C6410 SoC, how to get it work?
Message-ID: <201301240912.19490.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I'm trying to get the OHCI unit work on my S3C6410 SoC based Mini6410 but
without luck yet.

The driver in my Linux-3.7.4 always reports:

[...]
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
s3c2410-ohci s3c2410-ohci: s3c2410_start_hc:
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
s3c2410-ohci s3c2410-ohci: irq 79, io mem 0x74300000
s3c2410-ohci s3c2410-ohci: created debug files
s3c2410-ohci s3c2410-ohci: fminterval delta -11999
s3c2410-ohci s3c2410-ohci: enabling initreset quirk
s3c2410-ohci s3c2410-ohci: init err (00000000 0000)
s3c2410-ohci s3c2410-ohci: can't start s3c24xx
s3c2410-ohci s3c2410-ohci: OHCI controller state
s3c2410-ohci s3c2410-ohci: OHCI 0.0, NO legacy support registers, rh state halted
s3c2410-ohci s3c2410-ohci: control 0x000 HCFS=reset CBSR=0
s3c2410-ohci s3c2410-ohci: cmdstatus 0x00000 SOC=0
s3c2410-ohci s3c2410-ohci: intrstatus 0x00000000
s3c2410-ohci s3c2410-ohci: intrenable 0x00000000
s3c2410-ohci s3c2410-ohci: hcca frame #0000
s3c2410-ohci s3c2410-ohci: roothub.a 00000000 POTPGT=0 NDP=0(0)
s3c2410-ohci s3c2410-ohci: roothub.b 00000000 PPCM=0000 DR=0000
s3c2410-ohci s3c2410-ohci: roothub.status 00000000
s3c2410-ohci s3c2410-ohci: startup error -75
s3c2410-ohci s3c2410-ohci: USB bus 1 deregistered
s3c2410-ohci s3c2410-ohci: s3c2410_stop_hc:
s3c2410-ohci: probe of s3c2410-ohci failed with error -75
[...]

>From the error messages I guess the unit does not receive a clock. But as far
I can follow the code, the driver enables the correct clocks. From the data
sheet I know the OHCI unit shares the clock with the OTG unit. Has someone a
working OHCI on an S3C6410 SoC based system and can give me some hints how to
get it work on my Mini6410?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
