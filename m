From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 02 Jul 2013 23:48:08 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702174111.GF17110@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 2 Jul 2013 13:41:11 -0400")
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate>
 <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate>
 <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net>
Message-ID: <87y59ows4n.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

> On Tue, Jul 02, 2013 at 07:22:34PM +0200, Arnaud Ebalard wrote:
>> Hi,
>> 
>> Jason Cooper <jason@lakedaemon.net> writes:
>> 
>> >> The big problem is that the Armada 370 and Armada XP datasheets are
>> >> still only available under NDA, so it's quite hard for someone to step
>> >> up and do this, without access to those datasheets.
>> >
>> > bummer.
>> >
>> >> It used to be on our TODO-list, but isn't any longer, and I have no
>> >> informations about when it will re-appear on our TODO-list at this
>> >> point.
>> >
>> > So, Arnaud, how do you feel about tackling the nand driver based on the
>> > sources you have and the pointers above?
>> 
>> Sadly, I do not have enough spare time to work on this: at the moment, I
>> intend to focus on writing a clean driver for ISL 12057 RTC/Alarm chip
>> and get it accepted for 3.12.
>
> more bummer.  Willy, mind posting what you have?  Arnaud, do you have a
> link to the source code for your device?  And have you found the code
> they started with?

The code NETGEAR provides for ReadyNAS 102 is a (lightly) modified
version of KW40 LSP release 3.1.0-NQ. This is basically a 3.0.X kernel
(X=6 for Marvell LSP, X=56 in NETGEAR's tarball), with some 1,133,970
(no typo) lines patches on top of it:

 http://www.readynas.com/download/GPL/other/linux-ntgr-3.0.56.tar.xz

A quick look provides the following:

$ wc -l arch/arm/plat-armada/mv_drivers_lsp/mv_mtd/nand_nfc.c 
1761 arch/arm/plat-armada/mv_drivers_lsp/mv_mtd/nand_nfc.c

$ head -10 arch/arm/plat-armada/mv_drivers_lsp/mv_mtd/nand_nfc.c 
/*
 * nand_nfc.c
 *
 * Copyright c 2005 Intel Corporation
 * Copyright c 2006 Marvell International Ltd.
 *
 * This driver is based on the PXA drivers/mtd/nand/pxa3xx_nand.c
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as

Which matches what Thomas wrote in a previous email regarding pwa3xx
base. 

Cheers,

a+
