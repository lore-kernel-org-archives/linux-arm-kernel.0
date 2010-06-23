From: schindele@nentec.de (Juergen Schindele)
Date: Wed, 23 Jun 2010 17:06:32 +0200
Subject: strange segfaults with CompactFlash in "true-ide" mode on PXA270
Message-ID: <201006231706.33182.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear developers,
we have a strange problem when booting from a Compact Flash card
as root-device. In one of 10 cases while booting an application from
root-filesystem dies with "Segmentation fault" without a visible error.
After booting the same application runs hundred times without error.
(we're talking about standard appl. like chat, pppd, hwclock and so on)

For debugging purposes we put printk's in kernels IDE driver 
and the problem disappeared. But replacing the printk by a usleep
or so (which is not a solution !) brings the problem back.
It seems that the application received faulty data from CF.
But how and why ?????????????????????????????

We tested with a custom PXA270 board with a CompactFlash in 
"true ide" on processor bus driven by "generic ide / pata_platform"
driver from linux-2.6.27.x.
(by the way linux-2.6.20.x showed the same problem).

Any ideas, hints, experiences, patches are very welcome :-)
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

PSI NENTEC GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------
