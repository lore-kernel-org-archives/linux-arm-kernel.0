From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-1?q?M=FCes?=)
Date: Wed, 3 Mar 2010 08:34:31 +0100
Subject: [PATCH 4/7] mmc: at91_mci: use DMA buffer for read
In-Reply-To: <20100302133434.761df661.akpm@linux-foundation.org>
References: <20100302133434.761df661.akpm@linux-foundation.org>
Message-ID: <201003030834.31457.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am Dienstag, 2. M?rz 2010 schrieb Andrew Morton:
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
> 
> It's a feature of kunmap_atomic() that it will accept a pointer to any
> location in the page.  So the subtraction isn't strictly needed.
> 
> And if the subtraction is removed, the (void*) cast can also be removed.

I did not know this. Thank you for pointing this out. So this part of the 
patch (which was purely cosmetic because I have seen no error without the 
subtraction) can be omitted.

best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
