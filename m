From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 23 Jun 2010 17:24:15 +0200
Subject: strange segfaults with CompactFlash in "true-ide" mode on PXA270
In-Reply-To: <201006231706.33182.schindele@nentec.de>
References: <201006231706.33182.schindele@nentec.de>
Message-ID: <19490.10015.10027.750374@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> we have a strange problem when booting from a Compact Flash card
> as root-device. In one of 10 cases while booting an application from
> root-filesystem dies with "Segmentation fault" without a visible error.
> After booting the same application runs hundred times without error.
> (we're talking about standard appl. like chat, pppd, hwclock and so on)
> 
> For debugging purposes we put printk's in kernels IDE driver 
> and the problem disappeared. But replacing the printk by a usleep
> or so (which is not a solution !) brings the problem back.
> It seems that the application received faulty data from CF.
> But how and why ?????????????????????????????
> 
> We tested with a custom PXA270 board with a CompactFlash in 
> "true ide" on processor bus driven by "generic ide / pata_platform"
> driver from linux-2.6.27.x.
> (by the way linux-2.6.20.x showed the same problem).
> 
> Any ideas, hints, experiences, patches are very welcome :-)
> --------------------------------------------------------------
I guess that is the old cache problem that apparently was never really
fixed:
http://marc.info/?t=108537828400002&r=1&w=2


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
