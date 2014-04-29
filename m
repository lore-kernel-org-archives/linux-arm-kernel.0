From: stefan@agner.ch (Stefan Agner)
Date: Tue, 29 Apr 2014 09:50:58 +0200
Subject: [RFC 1/5] =?UTF-8?Q?mtd=3Afsl=5Fnfc=3A=20Nand=20flash=20contr?=
 =?UTF-8?Q?oller=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=2C=20etc=2E?=
In-Reply-To: <87mwf5v1lj.fsf@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-2-git-send-email-bpringlemeir@nbsps.com>
 <708e6f84e177e1d02310358688b44c53@agner.ch> <87mwf5v1lj.fsf@nbsps.com>
Message-ID: <0abdf97559279af681b6d2bfce26c947@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

Am 2014-04-28 18:51, schrieb Bill Pringlemeir:
> The email "reference" was a previous email I sent some time ago to the
> MTD mailing list.  I wondered if anyone was interested and I knew that
> people would not like the name 'fsl_nfc'.  But I don't know what to call
> it; it is a bike shed issue to me (specifics of what to call it), but I
> see how people will want to avoid a generic ambigious name like
> 'fsl_nfc'.

In all documentation and block diagram I've read Freescale itself calls
that IP "NAND Flash Controller", even with the abbreviation NFC. IMHO,
its a valid name then. The only alternative would probably be MCF5441x,
since this is the first device that controller appeared, but since this
is ColdFire microprocessor which isn't suited for Linux, a driver named
after it in the kernel tree would be somewhat weird.


> I was waiting to see about the clocking with HW-ECC; it seems above
> 33MHz, the HW-ECC module doesn't seem to work (at least for me).

Yes, I could also verify this (see my comment on that Freescale
Community post).

Appreciate your work, count me as interested!

This is my U-Boot port of the driver, I'm going to cleanup and test it
on the Tower:
http://git.toradex.com/gitweb/u-boot-toradex.git/shortlog/refs/heads/2014.04-colibri_vf

--
Stefan
