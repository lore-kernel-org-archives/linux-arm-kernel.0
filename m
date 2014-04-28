From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Mon, 28 Apr 2014 12:51:52 -0400
Subject: [RFC 1/5] mtd:fsl_nfc: Nand flash controller for VF610, MPC5125,
 etc.
In-Reply-To: <708e6f84e177e1d02310358688b44c53@agner.ch> (Stefan Agner's
 message of "Mon, 28 Apr 2014 16:41:48 +0200")
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-2-git-send-email-bpringlemeir@nbsps.com>
 <708e6f84e177e1d02310358688b44c53@agner.ch>
Message-ID: <87mwf5v1lj.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 Apr 2014, stefan at agner.ch wrote:

> The driver works fine for me using 3.14 on Colibri VF61 (8-Bit bus
> width, Samsung NAND, 2k page size). Also tested with the Hardware ECC.
> Do you plan to send an update patch of the driver?

> FYI, I ported the driver to U-Boot and will send a patch to the U-Boot
> mailing list soon.

> Some minor comments below:

Well, I would love it if there are only 'minor comments'.  I don't think
people will like the 'nfc' name.  I wanted a better name.  Also, the
'linux-mtd' list bounced my post because I used some 'Ref:' to refer to
another message.  It also bounce on the ARM list, but some kind
moderator put it through.

 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226623.html
 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226627.html
 etc.

Besides the Vybrid, the controller can support several other SOCs (some
ARM, some note), Such as the MPC5125 (PowerPC), MCF54418 (ColdFire) and
the Kinetis K70 (ARM Cortex-M).

I also have some tickets open on the Hardware ECC with the Vybrid.

 https://community.freescale.com/message/358284 - booting
 https://community.freescale.com/message/368216 - ECC value
 https://community.freescale.com/message/384556 - clocking

[There are also non-public freescale PR tickets]

Especially, the ECC layout is important.  I think that an HW ECC layout
with sub-page support is best.  The Linux-MTD community will want this
to be right.  

The email "reference" was a previous email I sent some time ago to the
MTD mailing list.  I wondered if anyone was interested and I knew that
people would not like the name 'fsl_nfc'.  But I don't know what to call
it; it is a bike shed issue to me (specifics of what to call it), but I
see how people will want to avoid a generic ambigious name like
'fsl_nfc'.

I was waiting to see about the clocking with HW-ECC; it seems above
33MHz, the HW-ECC module doesn't seem to work (at least for me).

Fwiw,
Bill Pringlemeir.
