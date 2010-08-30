From: wolfgang.mues@auerswald.de (=?ISO-8859-1?Q?Wolfgang_M=FCes?=)
Date: Mon, 30 Aug 2010 08:56:01 +0200
Subject: [PATCH 1/7] mmc: at91_mci: fix pointer errors
In-Reply-To: <4C7AD3A0.40607@bluewatersys.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<20100827193303.GB23079@void.printf.net>
	<4C7AD3A0.40607@bluewatersys.com>
Message-ID: <4C7B5601.5060505@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 29.08.2010 23:39, schrieb Ryan Mallon:
> I see this is already applied, but why all the type trickery here? Why
> not just:
>
> 	memcpy(dmabuf, sgbuffer, amount);
> 	dmabuf += amount / sizeof(dmabuf);

Because this is wrong?

Maybe you mean sizeof(*dmabuf)?

The exact style of the bug fix is not important, it's important that 
it's fixed.

best regards

i. A. Wolfgang Muees

Hardware-Entwicklung
Leiter Pruefen & Layout
-- 
Auerswald Gesellschaft fuer Datensysteme mbH

Phone: +49 5306-9219-562
Fax:   +49 5306-9200-94
--------------------------------------------------------------
Auerswald Gesellschaft fuer Datensysteme mbH,
Vor den Grashoefen 1, 38162 Cremlingen

Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
