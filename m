From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2018 13:13:25 +0200
Subject: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
Message-ID: <20180724111600.4158975-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost all files in the kernel are either plain text or UTF-8
encoded. A couple however are ISO_8859-1, usually just a few
characters in a C comments, for historic reasons.

This converts them all to UTF-8 for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/net/nfc/pn544.txt     |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts     |   2 +-
 arch/arm/crypto/sha256_glue.c                 |   2 +-
 arch/arm/crypto/sha256_neon_glue.c            |   4 +-
 drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
 drivers/iio/dac/ltc2632.c                     |   2 +-
 drivers/power/reset/ltc2952-poweroff.c        |   4 +-
 kernel/events/callchain.c                     |   2 +-
 net/netfilter/ipvs/Kconfig                    |   8 +-
 net/netfilter/ipvs/ip_vs_mh.c                 |   4 +-
 tools/power/cpupower/po/de.po                 |  44 +++----
 tools/power/cpupower/po/fr.po                 | 120 +++++++++---------
 12 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/pn544.txt b/Documentation/devicetree/bindings/net/nfc/pn544.txt
index 538a86f7b2b0..72593f056b75 100644
--- a/Documentation/devicetree/bindings/net/nfc/pn544.txt
+++ b/Documentation/devicetree/bindings/net/nfc/pn544.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 - compatible: Should be "nxp,pn544-i2c".
-- clock-frequency: I?C work frequency.
+- clock-frequency: I??C work frequency.
 - reg: address on the bus
 - interrupt-parent: phandle for the interrupt gpio controller
 - interrupts: GPIO interrupt to which the chip is connected
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 5d096528e75a..71c27ea0b53e 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -1,7 +1,7 @@
 /*
  * Copyright 2014 Open Source Support GmbH
  *
- * David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
+ * David Lanzend??rfer <david.lanzendoerfer@o2s.ch>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index bf8ccff2c9d0..0ae900e778f3 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -2,7 +2,7 @@
  * Glue code for the SHA256 Secure Hash Algorithm assembly implementation
  * using optimized ARM assembler and NEON instructions.
  *
- * Copyright ? 2015 Google Inc.
+ * Copyright ?? 2015 Google Inc.
  *
  * This file is based on sha256_ssse3_glue.c:
  *   Copyright (C) 2013 Intel Corporation
diff --git a/arch/arm/crypto/sha256_neon_glue.c b/arch/arm/crypto/sha256_neon_glue.c
index 9bbee56fbdc8..1d82c6cd31a4 100644
--- a/arch/arm/crypto/sha256_neon_glue.c
+++ b/arch/arm/crypto/sha256_neon_glue.c
@@ -2,10 +2,10 @@
  * Glue code for the SHA256 Secure Hash Algorithm assembly implementation
  * using NEON instructions.
  *
- * Copyright ? 2015 Google Inc.
+ * Copyright ?? 2015 Google Inc.
  *
  * This file is based on sha512_neon_glue.c:
- *   Copyright ? 2014 Jussi Kivilinna <jussi.kivilinna@iki.fi>
+ *   Copyright ?? 2014 Jussi Kivilinna <jussi.kivilinna@iki.fi>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghashp8-ppc.pl
index f746af271460..38b06503ede0 100644
--- a/drivers/crypto/vmx/ghashp8-ppc.pl
+++ b/drivers/crypto/vmx/ghashp8-ppc.pl
@@ -129,9 +129,9 @@ $code=<<___;
 	 le?vperm	$IN,$IN,$IN,$lemask
 	vxor		$zero,$zero,$zero
 
-	vpmsumd		$Xl,$IN,$Hl		# H.lo?Xi.lo
-	vpmsumd		$Xm,$IN,$H		# H.hi?Xi.lo+H.lo?Xi.hi
-	vpmsumd		$Xh,$IN,$Hh		# H.hi?Xi.hi
+	vpmsumd		$Xl,$IN,$Hl		# H.lo??Xi.lo
+	vpmsumd		$Xm,$IN,$H		# H.hi??Xi.lo+H.lo??Xi.hi
+	vpmsumd		$Xh,$IN,$Hh		# H.hi??Xi.hi
 
 	vpmsumd		$t2,$Xl,$xC2		# 1st phase
 
@@ -187,11 +187,11 @@ $code=<<___;
 .align	5
 Loop:
 	 subic		$len,$len,16
-	vpmsumd		$Xl,$IN,$Hl		# H.lo?Xi.lo
+	vpmsumd		$Xl,$IN,$Hl		# H.lo??Xi.lo
 	 subfe.		r0,r0,r0		# borrow?-1:0
-	vpmsumd		$Xm,$IN,$H		# H.hi?Xi.lo+H.lo?Xi.hi
+	vpmsumd		$Xm,$IN,$H		# H.hi??Xi.lo+H.lo??Xi.hi
 	 and		r0,r0,$len
-	vpmsumd		$Xh,$IN,$Hh		# H.hi?Xi.hi
+	vpmsumd		$Xh,$IN,$Hh		# H.hi??Xi.hi
 	 add		$inp,$inp,r0
 
 	vpmsumd		$t2,$Xl,$xC2		# 1st phase
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index cca278eaa138..885105135580 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -1,7 +1,7 @@
 /*
  * LTC2632 Digital to analog convertors spi driver
  *
- * Copyright 2017 Maxime Roussin-B?langer
+ * Copyright 2017 Maxime Roussin-B??langer
  * expanded by Silvan Murer <silvan.murer@gmail.com>
  *
  * Licensed under the GPL-2.
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 6b911b6b10a6..c484584745bc 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -2,7 +2,7 @@
  * LTC2952 (PowerPath) driver
  *
  * Copyright (C) 2014, Xsens Technologies BV <info@xsens.com>
- * Maintainer: Ren? Moll <linux@r-moll.nl>
+ * Maintainer: Ren?? Moll <linux@r-moll.nl>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -319,6 +319,6 @@ static struct platform_driver ltc2952_poweroff_driver = {
 
 module_platform_driver(ltc2952_poweroff_driver);
 
-MODULE_AUTHOR("Ren? Moll <rene.moll@xsens.com>");
+MODULE_AUTHOR("Ren?? Moll <rene.moll@xsens.com>");
 MODULE_DESCRIPTION("LTC PowerPath power-off driver");
 MODULE_LICENSE("GPL v2");
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c187aa3df3c8..24a77c34e9ad 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -4,7 +4,7 @@
  *  Copyright (C) 2008 Thomas Gleixner <tglx@linutronix.de>
  *  Copyright (C) 2008-2011 Red Hat, Inc., Ingo Molnar
  *  Copyright (C) 2008-2011 Red Hat, Inc., Peter Zijlstra
- *  Copyright  ?  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *  Copyright  ??  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  *
  * For licensing details see kernel-base/COPYING
  */
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 05dc1b77e466..cad48d07c818 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -296,10 +296,10 @@ config IP_VS_MH_TAB_INDEX
 	  stored in a hash table. This table is assigned by a preference
 	  list of the positions to each destination until all slots in
 	  the table are filled. The index determines the prime for size of
-	  the table as?251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
-	  65521 or 131071.?When using weights to allow destinations to
-	  receive more connections,?the table is assigned an amount
-	  proportional to the weights specified.?The table needs to be large
+	  the table as??251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
+	  65521 or 131071.??When using weights to allow destinations to
+	  receive more connections,??the table is assigned an amount
+	  proportional to the weights specified.??The table needs to be large
 	  enough to effectively fit all the destinations multiplied by their
 	  respective weights.
 
diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
index 0f795b186eb3..94d9d349ebb0 100644
--- a/net/netfilter/ipvs/ip_vs_mh.c
+++ b/net/netfilter/ipvs/ip_vs_mh.c
@@ -5,10 +5,10 @@
  *
  */
 
-/* The mh algorithm is to assign?a preference list of all the lookup
+/* The mh algorithm is to assign??a preference list of all the lookup
  * table positions to each destination and populate the table with
  * the most-preferred position of destinations. Then it is to select
- * destination with the hash key of source IP address?through looking
+ * destination with the hash key of source IP address??through looking
  * up a the lookup table.
  *
  * The algorithm is detailed in:
diff --git a/tools/power/cpupower/po/de.po b/tools/power/cpupower/po/de.po
index 78c09e51663a..840c17cc450a 100644
--- a/tools/power/cpupower/po/de.po
+++ b/tools/power/cpupower/po/de.po
@@ -323,12 +323,12 @@ msgstr "  Hardwarebedingte Grenzen der Taktfrequenz: "
 #: utils/cpufreq-info.c:256
 #, c-format
 msgid "  available frequency steps: "
-msgstr "  m?gliche Taktfrequenzen: "
+msgstr "  m??gliche Taktfrequenzen: "
 
 #: utils/cpufreq-info.c:269
 #, c-format
 msgid "  available cpufreq governors: "
-msgstr "  m?gliche Regler: "
+msgstr "  m??gliche Regler: "
 
 #: utils/cpufreq-info.c:280
 #, c-format
@@ -381,7 +381,7 @@ msgstr "Optionen:\n"
 msgid "  -e, --debug          Prints out debug information [default]\n"
 msgstr ""
 "  -e, --debug          Erzeugt detaillierte Informationen, hilfreich\n"
-"                       zum Aufsp?ren von Fehlern\n"
+"                       zum Aufsp??ren von Fehlern\n"
 
 #: utils/cpufreq-info.c:475
 #, c-format
@@ -424,7 +424,7 @@ msgstr "  -p, --policy         Findet die momentane Taktik heraus *\n"
 #: utils/cpufreq-info.c:482
 #, c-format
 msgid "  -g, --governors      Determines available cpufreq governors *\n"
-msgstr "  -g, --governors      Erzeugt eine Liste mit verf?gbaren Reglern *\n"
+msgstr "  -g, --governors      Erzeugt eine Liste mit verf??gbaren Reglern *\n"
 
 #: utils/cpufreq-info.c:483
 #, c-format
@@ -450,7 +450,7 @@ msgstr ""
 #, c-format
 msgid "  -s, --stats          Shows cpufreq statistics if available\n"
 msgstr ""
-"  -s, --stats          Zeigt, sofern m?glich, Statistiken ?ber cpufreq an.\n"
+"  -s, --stats          Zeigt, sofern m??glich, Statistiken ??ber cpufreq an.\n"
 
 #: utils/cpufreq-info.c:487
 #, c-format
@@ -473,9 +473,9 @@ msgid ""
 "cpufreq\n"
 "                       interface in 2.4. and early 2.6. kernels\n"
 msgstr ""
-"  -o, --proc           Erzeugt Informationen in einem ?hnlichem Format zu "
+"  -o, --proc           Erzeugt Informationen in einem ??hnlichem Format zu "
 "dem\n"
-"                       der /proc/cpufreq-Datei in 2.4. und fr?hen 2.6.\n"
+"                       der /proc/cpufreq-Datei in 2.4. und fr??hen 2.6.\n"
 "                       Kernel-Versionen\n"
 
 #: utils/cpufreq-info.c:491
@@ -491,7 +491,7 @@ msgstr ""
 #: utils/cpufreq-info.c:492 utils/cpuidle-info.c:152
 #, c-format
 msgid "  -h, --help           Prints out this screen\n"
-msgstr "  -h, --help           Gibt diese Kurz?bersicht aus\n"
+msgstr "  -h, --help           Gibt diese Kurz??bersicht aus\n"
 
 #: utils/cpufreq-info.c:495
 #, c-format
@@ -501,7 +501,7 @@ msgid ""
 msgstr ""
 "Sofern kein anderer Parameter als '-c, --cpu' angegeben wird, liefert "
 "dieses\n"
-"Programm Informationen, die z.B. zum Berichten von Fehlern n?tzlich sind.\n"
+"Programm Informationen, die z.B. zum Berichten von Fehlern n??tzlich sind.\n"
 
 #: utils/cpufreq-info.c:497
 #, c-format
@@ -557,7 +557,7 @@ msgid ""
 "select\n"
 msgstr ""
 "  -d FREQ, --min FREQ      neue minimale Taktfrequenz, die der Regler\n"
-"                           ausw?hlen darf\n"
+"                           ausw??hlen darf\n"
 
 #: utils/cpufreq-set.c:28
 #, c-format
@@ -566,7 +566,7 @@ msgid ""
 "select\n"
 msgstr ""
 "  -u FREQ, --max FREQ      neue maximale Taktfrequenz, die der Regler\n"
-"                           ausw?hlen darf\n"
+"                           ausw??hlen darf\n"
 
 #: utils/cpufreq-set.c:29
 #, c-format
@@ -579,20 +579,20 @@ msgid ""
 "  -f FREQ, --freq FREQ     specific frequency to be set. Requires userspace\n"
 "                           governor to be available and loaded\n"
 msgstr ""
-"  -f FREQ, --freq FREQ     setze exakte Taktfrequenz. Ben?tigt den Regler\n"
+"  -f FREQ, --freq FREQ     setze exakte Taktfrequenz. Ben??tigt den Regler\n"
 "                           'userspace'.\n"
 
 #: utils/cpufreq-set.c:32
 #, c-format
 msgid "  -r, --related            Switches all hardware-related CPUs\n"
 msgstr ""
-"  -r, --related            Setze Werte f?r alle CPUs, deren Taktfrequenz\n"
+"  -r, --related            Setze Werte f??r alle CPUs, deren Taktfrequenz\n"
 "                           hardwarebedingt identisch ist.\n"
 
 #: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
 #, c-format
 msgid "  -h, --help               Prints out this screen\n"
-msgstr "  -h, --help               Gibt diese Kurz?bersicht aus\n"
+msgstr "  -h, --help               Gibt diese Kurz??bersicht aus\n"
 
 #: utils/cpufreq-set.c:35
 #, fuzzy, c-format
@@ -618,8 +618,8 @@ msgstr ""
 "   angenommen\n"
 "2. Der Parameter -f bzw. --freq kann mit keinem anderen als dem Parameter\n"
 "   -c bzw. --cpu kombiniert werden\n"
-"3. FREQuenzen k?nnen in Hz, kHz (Standard), MHz, GHz oder THz eingegeben\n"
-"   werden, indem der Wert und unmittelbar anschlie?end (ohne Leerzeichen!)\n"
+"3. FREQuenzen k??nnen in Hz, kHz (Standard), MHz, GHz oder THz eingegeben\n"
+"   werden, indem der Wert und unmittelbar anschlie??end (ohne Leerzeichen!)\n"
 "   die Einheit angegeben werden. (Bsp: 1GHz )\n"
 "   (FREQuenz in kHz =^ MHz * 1000 =^ GHz * 1000000).\n"
 
@@ -638,7 +638,7 @@ msgid ""
 msgstr ""
 "Beim Einstellen ist ein Fehler aufgetreten. Typische Fehlerquellen sind:\n"
 "- nicht ausreichende Rechte (Administrator)\n"
-"- der Regler ist nicht verf?gbar bzw. nicht geladen\n"
+"- der Regler ist nicht verf??gbar bzw. nicht geladen\n"
 "- die angegebene Taktik ist inkorrekt\n"
 "- eine spezifische Frequenz wurde angegeben, aber der Regler 'userspace'\n"
 "  kann entweder hardwarebedingt nicht genutzt werden oder ist nicht geladen\n"
@@ -821,7 +821,7 @@ msgstr ""
 #: utils/cpuidle-info.c:48
 #, fuzzy, c-format
 msgid "Available idle states:"
-msgstr "  m?gliche Taktfrequenzen: "
+msgstr "  m??gliche Taktfrequenzen: "
 
 #: utils/cpuidle-info.c:71
 #, c-format
@@ -924,7 +924,7 @@ msgstr "Aufruf: cpufreq-info [Optionen]\n"
 msgid "  -s, --silent         Only show general C-state information\n"
 msgstr ""
 "  -e, --debug          Erzeugt detaillierte Informationen, hilfreich\n"
-"                       zum Aufsp?ren von Fehlern\n"
+"                       zum Aufsp??ren von Fehlern\n"
 
 #: utils/cpuidle-info.c:150
 #, fuzzy, c-format
@@ -933,9 +933,9 @@ msgid ""
 "acpi/processor/*/power\n"
 "                       interface in older kernels\n"
 msgstr ""
-"  -o, --proc           Erzeugt Informationen in einem ?hnlichem Format zu "
+"  -o, --proc           Erzeugt Informationen in einem ??hnlichem Format zu "
 "dem\n"
-"                       der /proc/cpufreq-Datei in 2.4. und fr?hen 2.6.\n"
+"                       der /proc/cpufreq-Datei in 2.4. und fr??hen 2.6.\n"
 "                       Kernel-Versionen\n"
 
 #: utils/cpuidle-info.c:209
@@ -949,7 +949,7 @@ msgstr ""
 #~ "  -c CPU, --cpu CPU    CPU number which information shall be determined "
 #~ "about\n"
 #~ msgstr ""
-#~ "  -c CPU, --cpu CPU    Nummer der CPU, ?ber die Informationen "
+#~ "  -c CPU, --cpu CPU    Nummer der CPU, ??ber die Informationen "
 #~ "herausgefunden werden sollen\n"
 
 #~ msgid ""
diff --git a/tools/power/cpupower/po/fr.po b/tools/power/cpupower/po/fr.po
index 245ad20a9bf9..b46ca2548f86 100644
--- a/tools/power/cpupower/po/fr.po
+++ b/tools/power/cpupower/po/fr.po
@@ -212,7 +212,7 @@ msgstr ""
 #: utils/cpupower.c:91
 #, c-format
 msgid "Report errors and bugs to %s, please.\n"
-msgstr "Veuillez rapportez les erreurs et les bogues ? %s, s'il vous plait.\n"
+msgstr "Veuillez rapportez les erreurs et les bogues ?? %s, s'il vous plait.\n"
 
 #: utils/cpupower.c:114
 #, c-format
@@ -227,14 +227,14 @@ msgstr ""
 #: utils/cpufreq-info.c:31
 #, c-format
 msgid "Couldn't count the number of CPUs (%s: %s), assuming 1\n"
-msgstr "D?termination du nombre de CPUs (%s : %s) impossible.  Assume 1\n"
+msgstr "D??termination du nombre de CPUs (%s : %s) impossible.  Assume 1\n"
 
 #: utils/cpufreq-info.c:63
 #, c-format
 msgid ""
 "          minimum CPU frequency  -  maximum CPU frequency  -  governor\n"
 msgstr ""
-"         Fr?quence CPU minimale - Fr?quence CPU maximale  - r?gulateur\n"
+"         Fr??quence CPU minimale - Fr??quence CPU maximale  - r??gulateur\n"
 
 #: utils/cpufreq-info.c:151
 #, c-format
@@ -302,12 +302,12 @@ msgstr "  pilote : %s\n"
 #: utils/cpufreq-info.c:219
 #, fuzzy, c-format
 msgid "  CPUs which run at the same hardware frequency: "
-msgstr "  CPUs qui doivent changer de fr?quences en m?me temps : "
+msgstr "  CPUs qui doivent changer de fr??quences en m??me temps : "
 
 #: utils/cpufreq-info.c:230
 #, fuzzy, c-format
 msgid "  CPUs which need to have their frequency coordinated by software: "
-msgstr "  CPUs qui doivent changer de fr?quences en m?me temps : "
+msgstr "  CPUs qui doivent changer de fr??quences en m??me temps : "
 
 #: utils/cpufreq-info.c:241
 #, c-format
@@ -317,22 +317,22 @@ msgstr ""
 #: utils/cpufreq-info.c:247
 #, c-format
 msgid "  hardware limits: "
-msgstr "  limitation mat?rielle : "
+msgstr "  limitation mat??rielle : "
 
 #: utils/cpufreq-info.c:256
 #, c-format
 msgid "  available frequency steps: "
-msgstr "  plage de fr?quence : "
+msgstr "  plage de fr??quence : "
 
 #: utils/cpufreq-info.c:269
 #, c-format
 msgid "  available cpufreq governors: "
-msgstr "  r?gulateurs disponibles : "
+msgstr "  r??gulateurs disponibles : "
 
 #: utils/cpufreq-info.c:280
 #, c-format
 msgid "  current policy: frequency should be within "
-msgstr "  tactique actuelle : la fr?quence doit ?tre comprise entre "
+msgstr "  tactique actuelle : la fr??quence doit ??tre comprise entre "
 
 #: utils/cpufreq-info.c:282
 #, c-format
@@ -345,18 +345,18 @@ msgid ""
 "The governor \"%s\" may decide which speed to use\n"
 "                  within this range.\n"
 msgstr ""
-"Le r?gulateur \"%s\" est libre de choisir la vitesse\n"
-"                  dans cette plage de fr?quences.\n"
+"Le r??gulateur \"%s\" est libre de choisir la vitesse\n"
+"                  dans cette plage de fr??quences.\n"
 
 #: utils/cpufreq-info.c:293
 #, c-format
 msgid "  current CPU frequency is "
-msgstr "  la fr?quence actuelle de ce CPU est "
+msgstr "  la fr??quence actuelle de ce CPU est "
 
 #: utils/cpufreq-info.c:296
 #, c-format
 msgid " (asserted by call to hardware)"
-msgstr " (v?rifi? par un appel direct du mat?riel)"
+msgstr " (v??rifi?? par un appel direct du mat??riel)"
 
 #: utils/cpufreq-info.c:304
 #, c-format
@@ -377,7 +377,7 @@ msgstr "Options :\n"
 #: utils/cpufreq-info.c:474
 #, fuzzy, c-format
 msgid "  -e, --debug          Prints out debug information [default]\n"
-msgstr "  -e, --debug          Afficher les informations de d?boguage\n"
+msgstr "  -e, --debug          Afficher les informations de d??boguage\n"
 
 #: utils/cpufreq-info.c:475
 #, c-format
@@ -385,8 +385,8 @@ msgid ""
 "  -f, --freq           Get frequency the CPU currently runs at, according\n"
 "                       to the cpufreq core *\n"
 msgstr ""
-"  -f, --freq           Obtenir la fr?quence actuelle du CPU selon le point\n"
-"                       de vue du coeur du syst?me de cpufreq *\n"
+"  -f, --freq           Obtenir la fr??quence actuelle du CPU selon le point\n"
+"                       de vue du coeur du syst??me de cpufreq *\n"
 
 #: utils/cpufreq-info.c:477
 #, c-format
@@ -394,8 +394,8 @@ msgid ""
 "  -w, --hwfreq         Get frequency the CPU currently runs at, by reading\n"
 "                       it from hardware (only available to root) *\n"
 msgstr ""
-"  -w, --hwfreq         Obtenir la fr?quence actuelle du CPU directement par\n"
-"                       le mat?riel (doit ?tre root) *\n"
+"  -w, --hwfreq         Obtenir la fr??quence actuelle du CPU directement par\n"
+"                       le mat??riel (doit ??tre root) *\n"
 
 #: utils/cpufreq-info.c:479
 #, c-format
@@ -403,13 +403,13 @@ msgid ""
 "  -l, --hwlimits       Determine the minimum and maximum CPU frequency "
 "allowed *\n"
 msgstr ""
-"  -l, --hwlimits       Affiche les fr?quences minimales et maximales du CPU "
+"  -l, --hwlimits       Affiche les fr??quences minimales et maximales du CPU "
 "*\n"
 
 #: utils/cpufreq-info.c:480
 #, c-format
 msgid "  -d, --driver         Determines the used cpufreq kernel driver *\n"
-msgstr "  -d, --driver         Affiche le pilote cpufreq utilis? *\n"
+msgstr "  -d, --driver         Affiche le pilote cpufreq utilis?? *\n"
 
 #: utils/cpufreq-info.c:481
 #, c-format
@@ -420,7 +420,7 @@ msgstr "  -p, --policy         Affiche la tactique actuelle de cpufreq *\n"
 #, c-format
 msgid "  -g, --governors      Determines available cpufreq governors *\n"
 msgstr ""
-"  -g, --governors      Affiche les r?gulateurs disponibles de cpufreq *\n"
+"  -g, --governors      Affiche les r??gulateurs disponibles de cpufreq *\n"
 
 #: utils/cpufreq-info.c:483
 #, fuzzy, c-format
@@ -429,7 +429,7 @@ msgid ""
 "frequency *\n"
 msgstr ""
 "  -a, --affected-cpus   Affiche quels sont les CPUs qui doivent changer de\n"
-"                        fr?quences en m?me temps *\n"
+"                        fr??quences en m??me temps *\n"
 
 #: utils/cpufreq-info.c:484
 #, fuzzy, c-format
@@ -438,7 +438,7 @@ msgid ""
 "                       coordinated by software *\n"
 msgstr ""
 "  -a, --affected-cpus   Affiche quels sont les CPUs qui doivent changer de\n"
-"                        fr?quences en m?me temps *\n"
+"                        fr??quences en m??me temps *\n"
 
 #: utils/cpufreq-info.c:486
 #, c-format
@@ -453,7 +453,7 @@ msgid ""
 "  -y, --latency        Determines the maximum latency on CPU frequency "
 "changes *\n"
 msgstr ""
-"  -l, --hwlimits       Affiche les fr?quences minimales et maximales du CPU "
+"  -l, --hwlimits       Affiche les fr??quences minimales et maximales du CPU "
 "*\n"
 
 #: utils/cpufreq-info.c:488
@@ -469,7 +469,7 @@ msgid ""
 "                       interface in 2.4. and early 2.6. kernels\n"
 msgstr ""
 "  -o, --proc           Affiche les informations en utilisant l'interface\n"
-"                       fournie par /proc/cpufreq, pr?sente dans les "
+"                       fournie par /proc/cpufreq, pr??sente dans les "
 "versions\n"
 "                       2.4 et les anciennes versions 2.6 du noyau\n"
 
@@ -485,7 +485,7 @@ msgstr ""
 #: utils/cpufreq-info.c:492 utils/cpuidle-info.c:152
 #, c-format
 msgid "  -h, --help           Prints out this screen\n"
-msgstr "  -h, --help           affiche l'aide-m?moire\n"
+msgstr "  -h, --help           affiche l'aide-m??moire\n"
 
 #: utils/cpufreq-info.c:495
 #, c-format
@@ -493,8 +493,8 @@ msgid ""
 "If no argument or only the -c, --cpu parameter is given, debug output about\n"
 "cpufreq is printed which is useful e.g. for reporting bugs.\n"
 msgstr ""
-"Par d?faut, les informations de d?boguage seront affich?es si aucun\n"
-"argument, ou bien si seulement l'argument -c (--cpu) est donn?, afin de\n"
+"Par d??faut, les informations de d??boguage seront affich??es si aucun\n"
+"argument, ou bien si seulement l'argument -c (--cpu) est donn??, afin de\n"
 "faciliter les rapports de bogues par exemple\n"
 
 #: utils/cpufreq-info.c:497
@@ -517,8 +517,8 @@ msgid ""
 "You can't specify more than one --cpu parameter and/or\n"
 "more than one output-specific argument\n"
 msgstr ""
-"On ne peut indiquer plus d'un param?tre --cpu, tout comme l'on ne peut\n"
-"sp?cifier plus d'un argument de formatage\n"
+"On ne peut indiquer plus d'un param??tre --cpu, tout comme l'on ne peut\n"
+"sp??cifier plus d'un argument de formatage\n"
 
 #: utils/cpufreq-info.c:600 utils/cpufreq-set.c:82 utils/cpupower-set.c:42
 #: utils/cpupower-info.c:42 utils/cpuidle-info.c:213
@@ -529,7 +529,7 @@ msgstr "option invalide\n"
 #: utils/cpufreq-info.c:617
 #, c-format
 msgid "couldn't analyze CPU %d as it doesn't seem to be present\n"
-msgstr "analyse du CPU %d impossible puisqu'il ne semble pas ?tre pr?sent\n"
+msgstr "analyse du CPU %d impossible puisqu'il ne semble pas ??tre pr??sent\n"
 
 #: utils/cpufreq-info.c:620 utils/cpupower-info.c:142
 #, c-format
@@ -547,8 +547,8 @@ msgid ""
 "  -d FREQ, --min FREQ      new minimum CPU frequency the governor may "
 "select\n"
 msgstr ""
-"  -d FREQ, --min FREQ       nouvelle fr?quence minimale du CPU ? utiliser\n"
-"                            par le r?gulateur\n"
+"  -d FREQ, --min FREQ       nouvelle fr??quence minimale du CPU ?? utiliser\n"
+"                            par le r??gulateur\n"
 
 #: utils/cpufreq-set.c:28
 #, c-format
@@ -556,13 +556,13 @@ msgid ""
 "  -u FREQ, --max FREQ      new maximum CPU frequency the governor may "
 "select\n"
 msgstr ""
-"  -u FREQ, --max FREQ       nouvelle fr?quence maximale du CPU ? utiliser\n"
-"                            par le r?gulateur\n"
+"  -u FREQ, --max FREQ       nouvelle fr??quence maximale du CPU ?? utiliser\n"
+"                            par le r??gulateur\n"
 
 #: utils/cpufreq-set.c:29
 #, c-format
 msgid "  -g GOV, --governor GOV   new cpufreq governor\n"
-msgstr "  -g GOV, --governor GOV   active le r?gulateur GOV\n"
+msgstr "  -g GOV, --governor GOV   active le r??gulateur GOV\n"
 
 #: utils/cpufreq-set.c:30
 #, c-format
@@ -570,9 +570,9 @@ msgid ""
 "  -f FREQ, --freq FREQ     specific frequency to be set. Requires userspace\n"
 "                           governor to be available and loaded\n"
 msgstr ""
-"  -f FREQ, --freq FREQ     fixe la fr?quence du processeur ? FREQ. Il faut\n"
-"                           que le r?gulateur ? userspace ? soit disponible \n"
-"                           et activ?.\n"
+"  -f FREQ, --freq FREQ     fixe la fr??quence du processeur ?? FREQ. Il faut\n"
+"                           que le r??gulateur ?? userspace ?? soit disponible \n"
+"                           et activ??.\n"
 
 #: utils/cpufreq-set.c:32
 #, c-format
@@ -582,7 +582,7 @@ msgstr ""
 #: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
 #, fuzzy, c-format
 msgid "  -h, --help               Prints out this screen\n"
-msgstr "  -h, --help           affiche l'aide-m?moire\n"
+msgstr "  -h, --help           affiche l'aide-m??moire\n"
 
 #: utils/cpufreq-set.c:35
 #, fuzzy, c-format
@@ -602,11 +602,11 @@ msgid ""
 "   (FREQuency in kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).\n"
 msgstr ""
 "Remarque :\n"
-"1. Le CPU num?ro 0 sera utilis? par d?faut si -c (ou --cpu) est omis ;\n"
-"2. l'argument -f FREQ (ou --freq FREQ) ne peut ?tre utilis? qu'avec --cpu ;\n"
-"3. on pourra pr?ciser l'unit? des fr?quences en postfixant sans aucune "
+"1. Le CPU num??ro 0 sera utilis?? par d??faut si -c (ou --cpu) est omis ;\n"
+"2. l'argument -f FREQ (ou --freq FREQ) ne peut ??tre utilis?? qu'avec --cpu ;\n"
+"3. on pourra pr??ciser l'unit?? des fr??quences en postfixant sans aucune "
 "espace\n"
-"   les valeurs par hz, kHz (par d?faut), MHz, GHz ou THz\n"
+"   les valeurs par hz, kHz (par d??faut), MHz, GHz ou THz\n"
 "   (kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).\n"
 
 #: utils/cpufreq-set.c:57
@@ -622,21 +622,21 @@ msgid ""
 "frequency\n"
 "   or because the userspace governor isn't loaded?\n"
 msgstr ""
-"En ajustant les nouveaux param?tres, une erreur est apparue. Les sources\n"
+"En ajustant les nouveaux param??tres, une erreur est apparue. Les sources\n"
 "d'erreur typique sont :\n"
-"- droit d'administration insuffisant (?tes-vous root ?) ;\n"
-"- le r?gulateur choisi n'est pas disponible, ou bien n'est pas disponible "
+"- droit d'administration insuffisant (??tes-vous root ?) ;\n"
+"- le r??gulateur choisi n'est pas disponible, ou bien n'est pas disponible "
 "en\n"
 "  tant que module noyau ;\n"
 "- la tactique n'est pas disponible ;\n"
-"- vous voulez utiliser l'option -f/--freq, mais le r?gulateur ? userspace ?\n"
-"  n'est pas disponible, par exemple parce que le mat?riel ne le supporte\n"
-"  pas, ou bien n'est tout simplement pas charg?.\n"
+"- vous voulez utiliser l'option -f/--freq, mais le r??gulateur ?? userspace ??\n"
+"  n'est pas disponible, par exemple parce que le mat??riel ne le supporte\n"
+"  pas, ou bien n'est tout simplement pas charg??.\n"
 
 #: utils/cpufreq-set.c:170
 #, c-format
 msgid "wrong, unknown or unhandled CPU?\n"
-msgstr "CPU inconnu ou non support? ?\n"
+msgstr "CPU inconnu ou non support?? ?\n"
 
 #: utils/cpufreq-set.c:302
 #, c-format
@@ -653,7 +653,7 @@ msgid ""
 "At least one parameter out of -f/--freq, -d/--min, -u/--max, and\n"
 "-g/--governor must be passed\n"
 msgstr ""
-"L'un de ces param?tres est obligatoire : -f/--freq, -d/--min, -u/--max et\n"
+"L'un de ces param??tres est obligatoire : -f/--freq, -d/--min, -u/--max et\n"
 "-g/--governor\n"
 
 #: utils/cpufreq-set.c:347
@@ -810,7 +810,7 @@ msgstr ""
 #: utils/cpuidle-info.c:48
 #, fuzzy, c-format
 msgid "Available idle states:"
-msgstr "  plage de fr?quence : "
+msgstr "  plage de fr??quence : "
 
 #: utils/cpuidle-info.c:71
 #, c-format
@@ -911,7 +911,7 @@ msgstr "Usage : cpufreq-info [options]\n"
 #: utils/cpuidle-info.c:149
 #, fuzzy, c-format
 msgid "  -s, --silent         Only show general C-state information\n"
-msgstr "  -e, --debug          Afficher les informations de d?boguage\n"
+msgstr "  -e, --debug          Afficher les informations de d??boguage\n"
 
 #: utils/cpuidle-info.c:150
 #, fuzzy, c-format
@@ -921,7 +921,7 @@ msgid ""
 "                       interface in older kernels\n"
 msgstr ""
 "  -o, --proc           Affiche les informations en utilisant l'interface\n"
-"                       fournie par /proc/cpufreq, pr?sente dans les "
+"                       fournie par /proc/cpufreq, pr??sente dans les "
 "versions\n"
 "                       2.4 et les anciennes versions 2.6 du noyau\n"
 
@@ -929,19 +929,19 @@ msgstr ""
 #, fuzzy, c-format
 msgid "You can't specify more than one output-specific argument\n"
 msgstr ""
-"On ne peut indiquer plus d'un param?tre --cpu, tout comme l'on ne peut\n"
-"sp?cifier plus d'un argument de formatage\n"
+"On ne peut indiquer plus d'un param??tre --cpu, tout comme l'on ne peut\n"
+"sp??cifier plus d'un argument de formatage\n"
 
 #~ msgid ""
 #~ "  -c CPU, --cpu CPU    CPU number which information shall be determined "
 #~ "about\n"
 #~ msgstr ""
-#~ "  -c CPU, --cpu CPU    Num?ro du CPU pour lequel l'information sera "
-#~ "affich?e\n"
+#~ "  -c CPU, --cpu CPU    Num??ro du CPU pour lequel l'information sera "
+#~ "affich??e\n"
 
 #~ msgid ""
 #~ "  -c CPU, --cpu CPU        number of CPU where cpufreq settings shall be "
 #~ "modified\n"
 #~ msgstr ""
-#~ "  -c CPU, --cpu CPU        num?ro du CPU ? prendre en compte pour les\n"
+#~ "  -c CPU, --cpu CPU        num??ro du CPU ?? prendre en compte pour les\n"
 #~ "                           changements\n"
-- 
2.18.0
